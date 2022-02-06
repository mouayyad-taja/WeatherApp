//
//  APIRemoteWearherTests.swift
//  WeatherAppTests
//
//  Created by Mouayyad Taja on 06/02/2022.
//

import XCTest
@testable import WeatherApp
import Reachability

class APIRemoteWearherTests: XCTestCase {

    var apiService : WeatherRepositoryProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        apiService = WeatherRemoteRepository()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        apiService = nil
    }
    
    // Asynchronous test: success fast, failure slow
    func testFetchListProducts() throws {
        let reachability = try Reachability()

        try XCTSkipUnless(
            reachability.connection != .unavailable,
            "Network connectivity needed for this test."
        )
        
        
        let promise = expectation(description: "Status code: 200")
        var responseError :Error?
        
        
        // when
        apiService.fetchWeatherForecast{ result in
            //then
            switch result {
            case .success(let data):
                break
            case .failure(let error):
                responseError = error
            }
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError, "Expected fetch products without retriving error")
    }
    
    
    func testCancelRequest() {
        guard let apiService = apiService as? WeatherRemoteRepository else {
            XCTAssert(false, "Expected failure when apiService is not WeatherRemoteRepository")
            return
        }
        apiService.fetchWeatherForecast{ result in
            // ignore call
        }
        
        // Expected to task nil after cancel
        apiService.cancelLastRequest()
        XCTAssertNil(apiService.request, "Expected request nil")
    }
}
