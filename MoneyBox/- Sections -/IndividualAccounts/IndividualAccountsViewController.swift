///
///  IndividualAccountsViewController.swift
///  MoneyBox
///
///  Created by Jonathan Simmons on 06/07/2023.
///

import UIKit

protocol IndividualAccountViewControllerDelegate: AnyObject {
    func individualAccountViewController(
        _ vc: IndividualAccountViewController,
        didUpdateProduct product: ProductRepresentation,
        withNewMoneyboxValue moneybox: Double?
    )
}

final class IndividualAccountViewController: UIViewController {
    
    let viewModel: IndividualAccountsViewModel
    weak var delegate: IndividualAccountViewControllerDelegate?
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    private let indAccountView = IndividualAccountView()
    
    init(viewModel: IndividualAccountsViewModel, delegate: IndividualAccountViewControllerDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureActivityIndicator()
        accountLogic()
        
        
    }
    
    // MARK: Private methods
    
    private func configureView() {
        view.addSubview(indAccountView)
        NSLayoutConstraint.activate([
            indAccountView.topAnchor.constraint(equalTo: view.topAnchor),
            indAccountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indAccountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indAccountView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        indAccountView.addButton.addTarget(self, action: #selector(addFundsToMoneybox), for: .touchUpInside)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: Selectors
    
    /// Set up of account data for the view
    private func accountLogic() {
        /// Selects which system image will be show based on the name of the product
        let product = viewModel.product
        
        if product.productFriendlyName == "Stocks & Shares ISA" {
            indAccountView.individualSavingsImage.image = UIImage(systemName: "chart.bar.fill")
        } else {
            indAccountView.individualSavingsImage.image = UIImage(systemName: "house.fill")
        }
        let planValueNumber = product.planValue ?? 0.0
        let moneyboxNumber = product.moneybox ?? 0.0
        
        /// Data for the Individual Account page
        indAccountView.individualAccountTitle.text = product.productFriendlyName ?? "Product name not found"
        indAccountView.individualPlanValueText.text = String(format: "Plan Value:  £%0.2f", planValueNumber)
        indAccountView.individualmoneyBoxAmount.text = String(format: "Moneybox:  £%0.2f", moneyboxNumber)
    }
    
    /// Funciton controlling the addition of funds to moneybox in each account
    @objc
    private func addFundsToMoneybox() {
        
        /// Activity Indicator On
        activityIndicator.startAnimating()
        viewModel.addFunds { [weak self] result in
            
            guard let self = self else { return }
            
            /// Activity Indicator Off
            activityIndicator.stopAnimating()
            
            switch result {
            case let .success(newMoneyboxValue):
                self.indAccountView.individualmoneyBoxAmount.text = String(format: "Moneybox: £%0.2f", newMoneyboxValue ?? 0)
                self.delegate?.individualAccountViewController(
                    self,
                    didUpdateProduct: self.viewModel.product,
                    withNewMoneyboxValue: newMoneyboxValue
                )
                
            case let .failure(error):
                ShowAlert.popUp(title: "Failed to insert funds", message: error.localizedDescription, inViewController: self)
                
            }
        }
    }
}
