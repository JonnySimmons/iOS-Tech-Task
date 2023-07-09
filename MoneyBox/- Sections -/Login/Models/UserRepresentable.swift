//
//  UserRepresentable.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import Foundation
import Networking

protocol UserRepresentable {
    var firstName: String? { get }
    var lastName: String? { get }
}

extension LoginResponse.User: UserRepresentable {}
