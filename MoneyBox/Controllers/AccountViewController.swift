//
//  AccountViewController.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit
import Networking

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var firstName: String?
    var productInformation: [ProductResponse] = []
    var totalPlanValue = 0.0
    
    private let dataProvider: DataProvider = {
        return DataProvider()
    }()

/// View information
    private let window: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let accountsTitle: UILabel = {
        let label = UILabel()
        label.text = "Accounts Summary"
        label.textAlignment = .center
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var welcomeText: UILabel = {
        let welcome = UILabel()
        let firstName = self.firstName // Assuming 'firstName' is declared as an instance variable or property
        welcome.text = "Hello, \(firstName ?? "Customer")."
        welcome.font = UIFont.systemFont(ofSize: 18)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    private lazy var PlanValueText: UILabel = {
        let total = UILabel()
        total.text = "Your Total Plan Value:"
        total.font = UIFont.systemFont(ofSize: 18)
        total.translatesAutoresizingMaskIntoConstraints = false
        return total
    }()
    
    private lazy var totalPlanValueText: UILabel = {
        let total = UILabel()
        let totalPlanValue = String(self.totalPlanValue)
        total.text = "£\(totalPlanValue)"
        total.font = UIFont.boldSystemFont(ofSize: 18)
        total.translatesAutoresizingMaskIntoConstraints = false
        return total
    }()
    
    private var tableView = UITableView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
/// Updated when screen appears
        fetchProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        fetchProducts()
        setupTableView()
    }
    

/// Call of API to obtain Account and Product data to be displayed in table and subsequent views
    private func fetchProducts() {
        
        dataProvider.fetchProducts { [weak self] result in
            switch result {
            case .success(let accountResponse):
            /// Total Plan Value is taken from the Account Responses
                if let totalPlanValueNumber = accountResponse.totalPlanValue {
                    self!.totalPlanValue = totalPlanValueNumber
                }
                
            /// extraction of Product Responses
                var productResponses: [ProductResponse] = []
                if let productData = accountResponse.productResponses {
                    for data in productData {
                        productResponses.append(data)
                    }
                } else {
                    ShowAlert.popUp(title: "", message: "Failed to find your account, please try again", inViewController: self!) {
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                }
            /// Storage of product resposes in product information. Update the total value and set up the screen now data in place
                self?.productInformation = productResponses
                self?.updateTotalPlanValueLabel()
                self?.AccountScreenSetup()
                self?.tableView.reloadData()
                
            case .failure(let error):
                ShowAlert.popUp(title: "Error Occured", message: error.localizedDescription, inViewController: self!) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
/// Update of the label for total
    private func updateTotalPlanValueLabel() {
        let totalPlanValue = String(format: "£%.2f", self.totalPlanValue)
        self.totalPlanValueText.text = "\(totalPlanValue)"
    }
    
    
/// Set up of table to show the Account data
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountInformationController.self, forCellReuseIdentifier: "AccountInfoCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
/// Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInformation.count
    }
    
/// Information in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfoCell", for: indexPath) as! AccountInformationController
        let productInfo = productInformation[indexPath.row]
        cell.update(with: productInfo)
        return cell
    }
    
/// Height of the rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
/// Tap functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    /// Position to enable information of which account pressed into Individual Account screen
        let position = indexPath.row
    /// Once tapped this will open the Individual Account in a seperate view
        let accountView = IndividualAccountViewController()
        accountView.productInformation = productInformation[position]
        navigationController?.pushViewController(accountView, animated: true)
    }
    
    
    
    func AccountScreenSetup(){
        view.addSubview(window)
        window.addSubview(accountsTitle)
        window.addSubview(welcomeText)
        window.addSubview(PlanValueText)
        window.addSubview(totalPlanValueText)
        window.addSubview(tableView)
      
        NSLayoutConstraint.activate([
            
            window.topAnchor.constraint(equalTo: view.topAnchor),
            window.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            window.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            window.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            accountsTitle.topAnchor.constraint(equalTo: window.topAnchor, constant: 75),
            accountsTitle.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0),
            accountsTitle.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 15),
            accountsTitle.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant:  -15),

            welcomeText.topAnchor.constraint(equalTo: accountsTitle.bottomAnchor, constant: 40),
            welcomeText.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 15),
            welcomeText.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -15),

            PlanValueText.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0),
            PlanValueText.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 5),
            
            totalPlanValueText.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0),
            totalPlanValueText.topAnchor.constraint(equalTo: PlanValueText.bottomAnchor, constant: 5),
            
            tableView.topAnchor.constraint(equalTo: totalPlanValueText.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])
    }
}
