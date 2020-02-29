//
//  DeezerServiceTests.swift
//  DeezerKitTests
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import XCTest
import NetworkKit

@testable import DeezerKit

class DeezerServiceTests: XCTestCase {

   var service: DeezerService!
   override func setUp() {
       service = DeezerService(network: MockNetwork())
   }
   
    func testSearch() {
        let expectation = XCTestExpectation(description: "should get search response")

        service.searchArtistsWith(text: "eminem") { result in
            switch result {
            case let .success(search):
                XCTAssertEqual(search.data.count, 25, "should have 25 search results")
                expectation.fulfill()
            case let .failure(error):
                XCTFail("should not get an error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testErrorResponse() {
        let expectation = XCTestExpectation(description: "should get search response")

        service.performNetworkRequest(DeezerAPI.album(id: 1),
                                      responseType: Album.self,
                                      shouldFail: true) { result in 
            switch result {
            case .success:
                XCTFail("should get an error")
            case let .failure(error):
                switch error {
                case let .networkError(error):
                    XCTFail("should have an api error but got \(error)")
                case let .apiError(apiError):
                    XCTAssertEqual(apiError.code, .dataNotFound, "should have error code 800")
                }
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
