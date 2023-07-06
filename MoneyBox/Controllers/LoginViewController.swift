//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

public class LoginViewController: UIViewController {
    
    private let dataProvider: DataProvider = {
        return DataProvider()
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        let moneyBoxImage = UIImage(named: "moneybox")
        let resizeImage = moneyBoxImage?.resized(to: CGSize(width: 200, height: 45))
        image.image = resizeImage
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let window: UIView = {
        let windowView = UIView()
        windowView.backgroundColor = UIColor(named: "GreyColor")
        windowView.translatesAutoresizingMaskIntoConstraints = false
        return windowView
    }()
    
    
    private let emailLabel: UILabel = {
        let eLabel = UILabel()
        eLabel.text = "Email address"
        eLabel.textAlignment = .left
        eLabel.textColor = UIColor(named: "AccentColor")
        eLabel.font = UIFont.systemFont(ofSize: 14)
        eLabel.translatesAutoresizingMaskIntoConstraints = false
        return eLabel
    }()
    
    
    private let emailInputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.autocapitalizationType = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let pLabel = UILabel()
        pLabel.text = "Password"
        pLabel.textAlignment = .left
        pLabel.textColor = UIColor(named: "AccentColor")
        pLabel.font = UIFont.systemFont(ofSize: 14)
        pLabel.translatesAutoresizingMaskIntoConstraints = false
        return pLabel
    }()
    
    private let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = ""
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        password.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return password
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor =  UIColor(named: "AccentColor")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        loginScreenSetup()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func loginScreenSetup() {
        view.addSubview(window)
        window.addSubview(emailLabel)
        window.addSubview(emailInputField)
        window.addSubview(passwordLabel)
        window.addSubview(passwordTextField)
        window.addSubview(loginButton)
        window.addSubview(image)
        
        NSLayoutConstraint.activate([
            window.topAnchor.constraint(equalTo: view.topAnchor),
            window.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            window.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            window.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -30),
            
            emailLabel.topAnchor.constraint(equalTo: emailInputField.topAnchor, constant: -20),
            emailLabel.leadingAnchor.constraint(equalTo: emailInputField.leadingAnchor, constant: 0),
            
            emailInputField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailInputField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            emailInputField.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            emailInputField.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 0),
            
            passwordTextField.topAnchor.constraint(equalTo: emailInputField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: emailInputField.leadingAnchor, constant: 0),
            passwordTextField.trailingAnchor.constraint(equalTo: emailInputField.trailingAnchor, constant: 0),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginButton.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20),
            
            window.widthAnchor.constraint(equalTo: view.widthAnchor),
            window.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    @objc private func loginButtonTapped() {
        guard let email = emailInputField.text, let password = passwordTextField.text else {
            return
        }
    /// Login Request using API
        let loginRequest = LoginRequest(email: email, password: password)
        dataProvider.login(request: loginRequest) { result in
            switch result {
            case .success(let loginResponse):
                
            /// Initialisation of the Networking Session Manger to obtain and hold the bearerToken
                let sessionManager = SessionManager()
                sessionManager.setUserToken(loginResponse.session.bearerToken)
                
            /// Obtain first name from login response
                guard let firstName = loginResponse.user.firstName else {
                    ShowAlert.popUp(title: "", message: "No first name availible", inViewController: self) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    return
                }
            /// Initialisation of the Account view and the following screen
                let account = AccountViewController()
            /// Assign the name that will be used in the Account screen
                account.firstName = firstName
            /// Make AccountViewController the main
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(account, animated: true)
                }
                
            case .failure(let error):
            /// Failure to Log in error cases
                ShowAlert.popUp(title: "", message: error.localizedDescription, inViewController: self) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}

