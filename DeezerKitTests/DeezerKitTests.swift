//
//  DeezerKitTests.swift
//  DeezerKitTests
//
//  Created by Andre Navarro on 2/28/20.
//  Copyright © 2020 DML. All rights reserved.
//

import XCTest
import NetworkKit

@testable import DeezerKit

class DeezerKitTests: XCTestCase {
    var service: DeezerService!
    override func setUp() {
        service = DeezerService(network: MockNetwork())
    }
    
    func testSearch() {
        let expectation = XCTestExpectation(description: "should get search response")

        service.network
            .request(DeezerAPI.searchArtists(text: "eminem"))
            .responseDecoded(of: Search.self, errorType: ErrorModel.self) { response in
            
                switch response.result {
                case let .success(search):
                    XCTAssertEqual(search.data.count, 25, "should have 25 search results")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
