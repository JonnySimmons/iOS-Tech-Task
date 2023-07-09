//
//  AccountCellView.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import Foundation
import UIKit

struct ProductRepresentation {
    let id: Int?
    let productFriendlyName: String?
    let planValue: Double?
    var moneybox: Double?
}

final class AccountTableViewCell: UITableViewCell {
    
    // MARK: Public Properties
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyColor")
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let savingsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let friendlyName: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let planValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moneyBoxAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    // MARK: Public methods
    
    func configure(with configuration: ProductRepresentation) {
        
        /// Selects which system image will be show based on the name of the product (more can be added as a seperate enum in future)
        if configuration.productFriendlyName == "Stocks & Shares ISA" {
            savingsImage.image = UIImage(systemName: "chart.bar.fill")
        } else {
            savingsImage.image = UIImage(systemName: "house.fill")
        }
        
        let planValueNumber = configuration.planValue ?? 0.0
        let moneyBoxAmountNumber = configuration.moneybox ?? 0.0
        
        /// Data for the Account information box
        friendlyName.text = configuration.productFriendlyName ?? "Product name not found"
        planValue.text = String(format: "Plan Value:  £%.02f", planValueNumber)
        moneyBoxAmount.text = String(format: "Moneybox:  £%0.2f", moneyBoxAmountNumber)
    }
    
    // MARK: Private methods
    
    private func configureView() {
        backgroundColor = UIColor.MB.grey
        selectionStyle = .none
        
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(container)
        
        container.addSubview(friendlyName)
        container.addSubview(planValue)
        container.addSubview(moneyBoxAmount)
        container.addSubview(arrowImage)
        container.addSubview(savingsImage)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            container.heightAnchor.constraint(equalToConstant: 110),
            
            savingsImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            savingsImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            savingsImage.widthAnchor.constraint(equalToConstant: 40),
            savingsImage.heightAnchor.constraint(equalToConstant: 40),
            
            friendlyName.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            friendlyName.leadingAnchor.constraint(equalTo: savingsImage.trailingAnchor, constant: 15),
            friendlyName.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -10),
            
            planValue.topAnchor.constraint(equalTo: friendlyName.bottomAnchor, constant: 15),
            planValue.leadingAnchor.constraint(equalTo: savingsImage.trailingAnchor, constant: 15),
            planValue.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            
            moneyBoxAmount.topAnchor.constraint(equalTo: planValue.bottomAnchor, constant: 8),
            moneyBoxAmount.leadingAnchor.constraint(equalTo: savingsImage.trailingAnchor, constant: 15),
            moneyBoxAmount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            moneyBoxAmount.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15),
            
            arrowImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
            arrowImage.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
