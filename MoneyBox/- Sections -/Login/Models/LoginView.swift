//
//  LoginView.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit


final class LoginView: UIView {
    
    // MARK: Public Properties
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = UIColor.MB.accent
        textField.autocapitalizationType = .none
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        password.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return password
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor =  UIColor.MB.accent
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    // MARK: Private properties
    
    private let image: UIImageView = {
        let image = UIImageView()
        let moneyBoxImage = UIImage(named: "moneybox")
        let resizeImage = moneyBoxImage?.resized(to: CGSize(width: 200, height: 45))
        image.image = resizeImage
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let emailLabel: UILabel = {
        let eLabel = UILabel()
        eLabel.text = "Email address"
        eLabel.textAlignment = .left
        eLabel.textColor = UIColor.MB.accent
        eLabel.font = UIFont.preferredFont(forTextStyle: .body)
        eLabel.adjustsFontForContentSizeCategory = true
        eLabel.translatesAutoresizingMaskIntoConstraints = false
        return eLabel
    }()
    
    private let passwordLabel: UILabel = {
        let pLabel = UILabel()
        pLabel.text = "Password"
        pLabel.textAlignment = .left
        pLabel.textColor = UIColor.MB.accent
        pLabel.font = UIFont.preferredFont(forTextStyle: .body)
        pLabel.adjustsFontForContentSizeCategory = true
        pLabel.translatesAutoresizingMaskIntoConstraints = false
        return pLabel
    }()
    
    // MARK: Lifecycle
    
    init() {
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    // MARK: Private methods
    
    private func configureView() {
        backgroundColor = UIColor.MB.grey
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -50),
            
            emailLabel.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -25),
            emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 0),
            
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -25),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 0),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 0),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 0),
            
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

