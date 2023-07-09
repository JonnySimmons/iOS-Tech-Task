//
//  AccountViewModel.swift
//  MoneyBox
//
//  Created by Jonathan Simmons on 06/07/2023.
//

import Foundation
import Networking

final class AccountViewModel {
    
    // MARK: Public properties
    
    let dataProvider: DataProviderLogic
    let firstName: String?
    
    private(set) var totalPlanValue = 0.0
    private(set) var products = [ProductRepresentation]()
    
    // MARK: Private properties
    
    private let sessionManager: SessionManager
    
    // MARK: Lifecycle
    
    init(firstName: String?, dataProvider: DataProviderLogic, sessionManager: SessionManager) {
        self.firstName = firstName
        self.dataProvider = dataProvider
        self.sessionManager = sessionManager
    }
    
    // MARK: Public methods
    
    typealias FetchCompletion = (Result<AccountRepresentable, Error>) -> Void
    
    func fetchProducts(completion: @escaping FetchCompletion) {
        dataProvider.fetchProducts { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(accountResponse):
                
                /// Total Plan Value is taken from the Account Responses
                if let totalPlanValueNumber = accountResponse.totalPlanValue {
                    self.totalPlanValue = totalPlanValueNumber
                }
                print("Number has changed to \(totalPlanValue)")
                var products = [ProductRepresentation]()
                
                /// extraction of Product Responses
                accountResponse.productResponses?.forEach { productResponse in
                    let configuration = ProductRepresentation(
                        id: productResponse.id,
                        productFriendlyName: productResponse.product?.friendlyName,
                        planValue: productResponse.planValue,
                        moneybox: productResponse.moneybox
                    )
                    products.append(configuration)
                }
                
                self.products = products
                
                completion(.success(accountResponse))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func update(product: ProductRepresentation, withNewMoneybox newMoneybox: Double?) {
        if let existingProductIndex = products.firstIndex(where: { product.id == $0.id }) {
            let oldMoneybox = product.moneybox ?? 0.0
            
            var product = products[existingProductIndex]
            product.moneybox = newMoneybox
            products[existingProductIndex] = product
            
            let diffMoneybox = (newMoneybox ?? 0) - oldMoneybox
            totalPlanValue += diffMoneybox
        }
    }
}
