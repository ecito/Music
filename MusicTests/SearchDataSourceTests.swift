//
//  SearchDataSourceTests.swift
//  MusicTests
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import XCTest
import DeezerKit
import NetworkKit

@testable import Music

class TestDependencies: Music.HasDeezerService {
    var deezerService = DeezerService(network: MockNetwork())
}

class SearchDataSourceTests: XCTestCase {

    var tableView: UITableView!
    var searchDataSource: SearchDataSource!

    override func setUp() {
        super.setUp()

        tableView = UITableView(frame: .zero, style: .plain)
        searchDataSource = SearchDataSource(dependencies: TestDependencies(), tableView: tableView)
    }
    
    func testSearchPopulatesDataSource() {
        let expectation = XCTestExpectation(description: "should get search response")

        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")
        
        searchDataSource.search("eminem") { result in
            
            XCTAssertNotNil(try? result.get())
            
            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 25, "should have 25 rows for the tableView")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchCancelled() {
        let expectation = XCTestExpectation(description: "should get search response")
        expectation.isInverted = true

        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")
        
        searchDataSource.search("eminem") { result in
            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 0, "should have no items")
            expectation.fulfill()
        }
        
        searchDataSource.cancelSearch()
        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchTwice() {
        let expectation = XCTestExpectation(description: "should get search response")
        expectation.isInverted = true

        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")
        
        searchDataSource.search("beyonce") { result in
            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 0, "should have no items")
            expectation.fulfill()
        }
        
        searchDataSource.cancelSearch()
        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")
        
        let expectation2 = XCTestExpectation(description: "should get search response")
        searchDataSource.search("eminem") { result in
            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 25, "should have 25 rows for the tableView")
            expectation2.fulfill()
        }

        wait(for: [expectation, expectation2], timeout: 2)
    }
}
