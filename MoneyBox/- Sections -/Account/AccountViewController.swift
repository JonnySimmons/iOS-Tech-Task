//
//  AccountViewController.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit

final class AccountViewController: UIViewController {
    
    let viewModel: AccountViewModel
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let accountView = AccountView()
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureActivityIndicator()
        fetchProducts()
    }
    
    // MARK: Private methods
    
    private func fetchProducts() {
        activityIndicator.startAnimating()
        viewModel.fetchProducts { [weak self] _ in
            self?.accountView.tableView.reloadData()
            self?.setDisplayValues()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func setDisplayValues() {
        let name = viewModel.firstName ?? "User"
        let number = String(viewModel.totalPlanValue)
        
        accountView.welcomeText.text = "Welcome back, \(name)."
        accountView.totalPlanValueText.text = "£\(number)"
    }
    
    private func configureView() {
        navigationItem.setHidesBackButton(true, animated: false)

        
        view.addSubview(accountView)
        NSLayoutConstraint.activate([
            
            accountView.topAnchor.constraint(equalTo: view.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupTableView()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupTableView() {
        accountView.tableView.translatesAutoresizingMaskIntoConstraints = false
        accountView.tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountInfoCell")
        accountView.tableView.dataSource = self
        accountView.tableView.delegate = self
        accountView.tableView.separatorStyle = .none
        accountView.tableView.backgroundColor = UIColor.MB.grey
    }
    
    private func updateTotalPlanValueLabel() {
        let totalPlanValue = String(format: "£%.2f", self.viewModel.totalPlanValue)
        self.accountView.totalPlanValueText.text = "\(totalPlanValue)"
    }
}

// MARK: UITableViewDataSource

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    /// Information in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfoCell", for: indexPath) as? AccountTableViewCell
        else {
            assert(false, "Unable to deque a cell. Please make sure you've registered it properly")
            return UITableViewCell()
        }
        
        let cellConfiguration = viewModel.products[indexPath.row]
        cell.configure(with: cellConfiguration)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension AccountViewController: UITableViewDelegate {
    /// Tap functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = viewModel.products[indexPath.row]
        
        pushFundsAccount(product: product)
    }
}

// MARK: IndividualAccountViewControllerDelegate

extension AccountViewController: IndividualAccountViewControllerDelegate {
    func individualAccountViewController(
        _ vc: IndividualAccountViewController,
        didUpdateProduct product: ProductRepresentation,
        withNewMoneyboxValue moneybox: Double?
    ) {
        viewModel.update(product: product, withNewMoneybox: moneybox)
        
        accountView.tableView.reloadData()
        setDisplayValues()
    }
}

// MARK: Private

private extension AccountViewController {
    
    /// Position to enable information of which account pressed into Individual Account screen
    private func pushFundsAccount(product: ProductRepresentation) {
        let viewModel = IndividualAccountsViewModel(product: product, dataProvider: viewModel.dataProvider)
        let viewController = IndividualAccountViewController(viewModel: viewModel, delegate: self)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
