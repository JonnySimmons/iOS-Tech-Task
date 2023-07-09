//
//  LoginTest.swift
//  MoneyBoxTests
//
//  Created by Jonathan Simmons on 09/07/2023.
//

import XCTest
import Networking

final class NetworkingTest: XCTestCase {
    
    let dataProvider = MockDataProvider()

    func testLogin() {
        let request = LoginRequest(email: "test+ios2@moneyboxapp.com", password: "P455word12")

        dataProvider.login(request: request) { result in
            switch result {
            case .success(let response):
                
                XCTAssertNotNil(response.user)
                XCTAssertNotNil(response.session)
            /// Specffic tests
                XCTAssertEqual(response.user.firstName, "Michael")
                XCTAssertEqual(response.user.lastName, "Jordan")
                XCTAssertEqual(response.session.bearerToken, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
                print("yes")
            case .failure(let error):
                
                XCTFail("Use of login failed, \(error.localizedDescription)")
            }
        }
    }
    
    func testFetchProducts() {
        dataProvider.fetchProducts { result in
            switch result {
            case .success(let response):

                XCTAssertNotNil(response.accounts)
                XCTAssertNotNil(response.totalPlanValue)
                XCTAssertNotNil(response.productResponses)
            /// Specffic tests
                XCTAssertEqual(response.moneyboxEndOfTaxYear, "2022-03-23T12:00:00.000")
                XCTAssertEqual(response.totalPlanValue, 15707.080000)
                XCTAssertEqual(response.accounts?.count, 2)
                XCTAssertEqual(response.productResponses?.count, 2)
                
            case .failure(let error):

                XCTFail("Use of fetchProducts failed,  \(error.localizedDescription)")
            }
        }
    }
    
}

