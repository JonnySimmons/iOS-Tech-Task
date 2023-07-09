//
//  MockDataProvider.swift
//  MoneyBoxTests
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import UIKit
import Networking

class MockDataProvider: DataProviderLogic {
    
    func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, Error>) in
            completion(result)
        }
    }
    
    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        
        StubData.read(file: "Accounts") { (result: Result<AccountResponse, Error>) in
            completion(result)
        }
    }
    
    func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        
        StubData.read(file: "Accounts") { (result: Result<OneOffPaymentResponse, Error>) in
            completion(result)
        }
    }
}
