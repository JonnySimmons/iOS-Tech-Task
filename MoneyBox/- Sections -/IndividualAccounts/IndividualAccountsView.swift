//
//  IndividualAccountsView.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit

final class IndividualAccountView: UIView {
    
    // MARK: Public Properties
    
    let individualAccountTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.MB.accent
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let individualSavingsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let individualPlanValueText: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let individualmoneyBoxAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add £10", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = UIColor.MB.accent
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
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
        
        setupAccountView()
    }
    
    private func setupAccountView() {
        addSubview(individualAccountTitle)
        addSubview(individualSavingsImage)
        addSubview(individualPlanValueText)
        addSubview(individualmoneyBoxAmount)
        addSubview(addButton)
        
        NSLayoutConstraint.activate([
            individualAccountTitle.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            individualAccountTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            individualAccountTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            individualAccountTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -15),
            
            individualSavingsImage.topAnchor.constraint(equalTo: individualAccountTitle.bottomAnchor, constant: 40),
            individualSavingsImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            individualSavingsImage.widthAnchor.constraint(equalToConstant: 80),
            individualSavingsImage.heightAnchor.constraint(equalToConstant: 80),
            
            individualPlanValueText.topAnchor.constraint(equalTo: individualSavingsImage.bottomAnchor, constant: 30),
            individualPlanValueText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
//            individualPlanValueText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            individualmoneyBoxAmount.topAnchor.constraint(equalTo: individualPlanValueText.bottomAnchor, constant: 10),
            individualmoneyBoxAmount.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
//            individualmoneyBoxAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            addButton.topAnchor.constraint(equalTo: individualmoneyBoxAmount.bottomAnchor, constant: 50),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
