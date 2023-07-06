//
//  IndividualAccountViewController.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit
import Networking

class IndividualAccountViewController: UIViewController {
    
    private let dataProvider: DataProvider = {
        return DataProvider()
    }()
    
    var productInformation: ProductResponse?
    
/// View Information
    private let window: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let individualAccountTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let individualSavingsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let individualPlanValueText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let individualmoneyBoxAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add £10", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor =  UIColor(named: "AccentColor")
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "GreyColor")
        accountLogic()
        setupAccountView()
        addButton.addTarget(self, action: #selector(addFundsToMoneybox), for: .touchUpInside)
    }
    
    private func setupAccountView() {
        view.addSubview(window)
        window.addSubview(individualAccountTitle)
        window.addSubview(individualSavingsImage)
        window.addSubview(individualPlanValueText)
        window.addSubview(individualmoneyBoxAmount)
        window.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            window.topAnchor.constraint(equalTo: view.topAnchor),
            window.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            window.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            window.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            individualAccountTitle.topAnchor.constraint(equalTo: window.topAnchor, constant: 100),
            individualAccountTitle.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0),
            individualAccountTitle.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 15),
            individualAccountTitle.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant:  -15),
            
            individualSavingsImage.topAnchor.constraint(equalTo: individualAccountTitle.bottomAnchor, constant: 40),
            individualSavingsImage.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0),
            individualSavingsImage.widthAnchor.constraint(equalToConstant: 80),
            individualSavingsImage.heightAnchor.constraint(equalToConstant: 80),
            
            individualPlanValueText.topAnchor.constraint(equalTo: individualSavingsImage.bottomAnchor, constant: 30),
            individualPlanValueText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            individualmoneyBoxAmount.topAnchor.constraint(equalTo: individualPlanValueText.bottomAnchor, constant: 10),
            individualmoneyBoxAmount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            addButton.topAnchor.constraint(equalTo: individualmoneyBoxAmount.bottomAnchor, constant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
/// Set up of account data for the view
    private func accountLogic() {
    /// Selects which system image will be show based on the name of the product
        guard let product = productInformation else { return }
        if product.product?.friendlyName == "Stocks & Shares ISA" {
            individualSavingsImage.image = UIImage(systemName: "chart.bar.fill")
        } else {
            individualSavingsImage.image = UIImage(systemName: "house.fill")
        }
        let planValueNumber = product.planValue ?? 0.0
        let moneyboxNumber = product.moneybox ?? 0.0
    /// Data for the Individual Account page
        individualAccountTitle.text = product.product?.friendlyName ?? "Product name not found"
        individualPlanValueText.text = String(format: "Plan Value: £%0.2f", planValueNumber)
        individualmoneyBoxAmount.text = String(format: "Moneybox: £%0.2f", moneyboxNumber)
    }
    
/// Funciton controlling the addition of funds to moneybox in each account
    @objc private func addFundsToMoneybox() {
        guard let product = productInformation else { return }
        
        let fixedPayment = 10.0
        let id = product.id ?? 2023
        let request = OneOffPaymentRequest(amount: Int(fixedPayment), investorProductID: id)
    /// Add funds using the Data Provider
        dataProvider.addMoney(request: request) { result in
            switch result {
            case .success(let paymentResponse):
                
                DispatchQueue.main.async {
                    self.individualmoneyBoxAmount.text = String(format: "Moneybox: £%0.2f", paymentResponse.moneybox!)
                }
                
            case .failure(let error):
                ShowAlert.popUp(title: "Failed to insert funds", message: error.localizedDescription, inViewController: self) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
