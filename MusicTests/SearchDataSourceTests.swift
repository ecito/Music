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

class TestDependencies: HasDeezerService {
    var deezerService = DeezerService(network: MockNetwork())
}

class SearchDataSourceTests: XCTestCase {

    var tableView: UITableView!
    var searchDataSource: SearchDataSource!

    override func setUp() {
        super.setUp()

        tableView = UITableView(frame: .zero, style: .plain)
        searchDataSource = SearchDataSource(dependencies: TestDependencies(), tableView: tableView, cellProvider: { _, _, _ in return UITableViewCell() })
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

        searchDataSource.search("eminem") { _ in
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

        searchDataSource.search("beyonce") { _ in
            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 0, "should have no items")
            expectation.fulfill()
        }

        searchDataSource.cancelSearch()
        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")

        let expectation2 = XCTestExpectation(description: "should get search response")
        searchDataSource.search("eminem") { _ in
            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 25, "should have 25 rows for the tableView")
            expectation2.fulfill()
        }

        wait(for: [expectation, expectation2], timeout: 2)
    }

    func testSearchPaging() {
        let expectation = XCTestExpectation(description: "should get search response")

        XCTAssertEqual(searchDataSource.tableViewDataSource.snapshot().numberOfItems, 0, "should have no items")
        searchDataSource.searchLimit = 2
        searchDataSource.search("asdf", index: 0) { result in
            XCTAssertNotNil(try? result.get())

            let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
            XCTAssertEqual(snapshot.numberOfItems, 2, "should have 2 rows for the tableView")

            self.searchDataSource.search("asdf", index: 2) { result in
                XCTAssertNotNil(try? result.get())

                let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
                XCTAssertEqual(snapshot.numberOfItems, 4, "should have 4 rows for the tableView")

                self.searchDataSource.search("asdf", index: 4) { result in
                    XCTAssertNotNil(try? result.get())

                    let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
                    XCTAssertEqual(snapshot.numberOfItems, 6, "should have 6 rows for the tableView")

                    self.searchDataSource.search("asdf", index: 6) { result in
                        XCTAssertNil(try? result.get())

                        let snapshot = self.searchDataSource.tableViewDataSource.snapshot()
                        XCTAssertEqual(snapshot.numberOfItems, 6, "should have 6 rows for the tableView")

                        expectation.fulfill()
                    }
                }
            }
        }

        wait(for: [expectation], timeout: 5)
    }
}
