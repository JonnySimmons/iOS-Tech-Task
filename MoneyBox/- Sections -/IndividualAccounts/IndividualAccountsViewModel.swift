//
//  IndividualAccountsViewModel.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import Foundation
import Networking

final class IndividualAccountsViewModel {
    
    static let amountToFund: Int = 10
    
    let product: ProductRepresentation
    
    private let dataProvider: DataProviderLogic
    
    // MARK: Lifecycle
    
    init(product: ProductRepresentation, dataProvider: DataProviderLogic) {
        self.product = product
        self.dataProvider = dataProvider
    }
    
    // MARK: Public methods
    
    typealias AddFundsCompletion = (Result<Double?, Error>) -> Void
    
    func addFunds(completion: @escaping AddFundsCompletion) {
        guard let investorProductId = product.id else {
            completion(.failure(MoneyBoxError.unableToFundAccount))
            return
        }
        
        let request = OneOffPaymentRequest(
            amount: IndividualAccountsViewModel.amountToFund,
            investorProductID: investorProductId
        )
        
        /// Add funds using the Data Provider
        dataProvider.addMoney(request: request) { result in
            switch result {
            case let .success(paymentResponse):
                completion(.success((paymentResponse.moneybox)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
