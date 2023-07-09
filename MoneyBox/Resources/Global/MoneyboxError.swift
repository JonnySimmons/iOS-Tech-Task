//
//  MoneyboxError.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import Foundation

enum MoneyBoxError: Error {
    case missingFirstNameInTheResponse
    case unableToFundAccount
}

extension MoneyBoxError: CustomStringConvertible {
    var description: String {
        switch self {
        case .missingFirstNameInTheResponse:
            return "Cannot find actual first name for this credentials"
        case .unableToFundAccount:
            return "Unable to fund this account. Please try again later"
        }
    }
}
