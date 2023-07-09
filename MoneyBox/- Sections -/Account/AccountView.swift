//
//  AccountView.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit

final class AccountView: UIView {
    
    // MARK: Public Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Private properties
    
    private let accountsTitle: UILabel = {
        let label = UILabel()
        label.text = "Accounts Summary"
        label.textAlignment = .center
        label.textColor = UIColor.MB.accent
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var welcomeText: UILabel = {
        let welcome = UILabel()
        welcome.font = UIFont.preferredFont(forTextStyle: .headline)
        welcome.adjustsFontForContentSizeCategory = true
        welcome.translatesAutoresizingMaskIntoConstraints = false
        return welcome
    }()
    
    private lazy var PlanValueText: UILabel = {
        let total = UILabel()
        total.text = "Your Total Plan Value:"
        total.font = UIFont.preferredFont(forTextStyle: .headline)
        total.adjustsFontForContentSizeCategory = true
        total.translatesAutoresizingMaskIntoConstraints = false
        return total
    }()
    
    lazy var totalPlanValueText: UILabel = {
        let total = UILabel()
        total.font = UIFont.preferredFont(forTextStyle: .headline)
        total.adjustsFontForContentSizeCategory = true
        total.translatesAutoresizingMaskIntoConstraints = false
        return total
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
        
        configureContraints()
    }
    
    func configureContraints(){
        addSubview(accountsTitle)
        addSubview(welcomeText)
        addSubview(PlanValueText)
        addSubview(totalPlanValueText)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            accountsTitle.topAnchor.constraint(equalTo: topAnchor, constant: 75),
            accountsTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            accountsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            accountsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -15),
            
            welcomeText.topAnchor.constraint(equalTo: accountsTitle.bottomAnchor, constant: 40),
            welcomeText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            welcomeText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            PlanValueText.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 20),
            PlanValueText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            PlanValueText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            totalPlanValueText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            totalPlanValueText.topAnchor.constraint(equalTo: PlanValueText.bottomAnchor, constant: 5),
            
            tableView.topAnchor.constraint(equalTo: totalPlanValueText.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
