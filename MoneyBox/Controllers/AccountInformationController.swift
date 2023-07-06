//
//  AccountInformationController.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit
import Networking

class AccountInformationController: UITableViewCell {
    
/// View Information
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyColor")
        //        view.tintColor = UIColor(named: "AccentColor")
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
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
    
    private let savingsImage: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let friendlyName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let planValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moneyBoxAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(container)
        container.addSubview(friendlyName)
        container.addSubview(planValue)
        container.addSubview(moneyBoxAmount)
        container.addSubview(arrowImage)
        container.addSubview(savingsImage)
        
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            savingsImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            savingsImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            savingsImage.widthAnchor.constraint(equalToConstant: 40),
            savingsImage.heightAnchor.constraint(equalToConstant: 40),
            
            friendlyName.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            friendlyName.leadingAnchor.constraint(equalTo: savingsImage.trailingAnchor, constant: 15),
            friendlyName.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -10),
            
            planValue.topAnchor.constraint(equalTo: friendlyName.bottomAnchor, constant: 5),
            planValue.leadingAnchor.constraint(equalTo: savingsImage.trailingAnchor, constant: 15),
            planValue.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            
            moneyBoxAmount.topAnchor.constraint(equalTo: planValue.bottomAnchor, constant: 5),
            moneyBoxAmount.leadingAnchor.constraint(equalTo: savingsImage.trailingAnchor, constant: 15),
            moneyBoxAmount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            moneyBoxAmount.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15),
            
            arrowImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
            arrowImage.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func update(with product: ProductResponse) {
    /// Selects which system image will be show based on the name of the product
        if product.product?.friendlyName == "Stocks & Shares ISA" {
            savingsImage.image = UIImage(systemName: "chart.bar.fill")
        } else {
            savingsImage.image = UIImage(systemName: "house.fill")
        }
        let planValueNumber = product.planValue ?? 0.0
        let moneyBoxAmountNumber = product.moneybox ?? 0.0
    /// Data for the Account information box
        friendlyName.text = product.product?.friendlyName ?? "Product name not found"
        planValue.text = String(format: "Plan Value: £%.02f", planValueNumber)
        moneyBoxAmount.text = String(format: "Moneybox:  £%0.2f", moneyBoxAmountNumber)
    }
    
}
