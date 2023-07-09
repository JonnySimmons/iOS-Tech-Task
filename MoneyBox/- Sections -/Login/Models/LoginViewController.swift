//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let viewModel: LoginViewModel
    private let loginView = LoginView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(viewModel: LoginViewModel) {
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
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        
        /// In place for easy login if needed

        #if DEBUG
                loginView.emailTextField.text = "test+ios2@moneyboxapp.com"
                loginView.passwordTextField.text = "P455word12"
        #endif
    }
    
    // MARK: Private methods
    
    private func configureView() {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: Selectors
    
    @objc
    private func loginButtonTapped() {
        guard
            let email = loginView.emailTextField.text,
            let password = loginView.passwordTextField.text
        else {
            return
        }
        /// Activity Indicator
        activityIndicator.startAnimating()
        
        viewModel.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            /// Activity indicator off
            activityIndicator.stopAnimating()
            
            switch result {
                
            case let .success(user):
                self.pushAccount(user: user)
                
            case let .failure(error):
                ShowAlert.popUp(message: error.localizedDescription, inViewController: self)
            }
        }
    }
    
    private func pushAccount(user: UserRepresentable) {
        let accountViewModel = AccountViewModel(firstName: user.firstName, dataProvider: viewModel.dataProvider, sessionManager: viewModel.sessionManager)
        let accountViewController = AccountViewController(viewModel: accountViewModel)
        
        navigationController?.pushViewController(accountViewController, animated: true)
    }
}

extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
