//
//  AccountRepresentable.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 07/07/2023.
//

import Foundation
import Networking

protocol AccountRepresentable {
    var moneyboxEndOfTaxYear: String? { get }
    var totalPlanValue: Double? { get }
    var totalEarnings: Double? { get }
    var totalContributionsNet: Double? { get }
    var totalEarningsAsPercentage: Double? { get }
    var productResponses: [ProductResponse]? { get }
    var accounts: [Account]? { get }
}

extension AccountResponse: AccountRepresentable {}
