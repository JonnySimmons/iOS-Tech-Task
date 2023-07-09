//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import Foundation
import Networking

final class LoginViewModel {
    
    let dataProvider: DataProviderLogic
    let sessionManager: SessionManager
    
    // MARK: Lifecycle
    
    init(dataProvider: DataProviderLogic = DataProvider(), sessionManager: SessionManager) {
        self.dataProvider = dataProvider
        self.sessionManager = sessionManager
    }
    
    // MARK: Public methods
    
    typealias LoginCompletion = (Result<UserRepresentable, Error>) -> Void
    
    func login(email: String, password: String, completion: @escaping LoginCompletion) {
        let loginRequest = LoginRequest(email: email, password: password)
        
        dataProvider.login(request: loginRequest) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(loginResponse):
                
                /// Obtain first name from login response
                guard let firstName = loginResponse.user.firstName, !firstName.isEmpty else {
                    completion(.failure(MoneyBoxError.missingFirstNameInTheResponse))
                    return
                }
                
                /// Initialisation of the Networking Session Manger to obtain and hold the bearerToken
                self.sessionManager.setUserToken(loginResponse.session.bearerToken)
                
                completion(.success(loginResponse.user))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

