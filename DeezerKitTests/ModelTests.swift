//
//  ModelTests.swift
//  DeezerKitTests
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import XCTest
import NetworkKit

class ModelTests: XCTestCase {
    
    var network = MockNetwork()
    
    func testSearch() {
        let expectation = XCTestExpectation(description: "should get search response")
        
        network
            .request(DeezerAPI.searchArtists(text: "eminem", index: nil, limit: nil))
            .responseDecoded(of: Search.self, errorType: DeezerAPIError.self) { response in
                print(response.debugDescription)
                switch response.result {
                case let .success(search):
                    let firstItem = search.data[0]
                    XCTAssertEqual(firstItem.id, 13, "should have id")
                    XCTAssertEqual(firstItem.name, "Eminem", "should have title")
                    XCTAssertEqual(search.data.count, 25, "should have 25 search results")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
