//
//  DeezerValidatorTests.swift
//  DeezerKitTests
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import XCTest
@testable import DeezerKit

class DeezerValidatorTests: XCTestCase {

    func testSuccessStatusCodeWithValidData() {
        let response = HTTPURLResponse(url: URL(string: "http://api.deezer.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let validator = DeezerValidator()
        let result = validator.validate(data: nil, urlResponse: response, error: nil)

        XCTAssertTrue(result, "should pass validation")
    }

    func testSuccessStatusCodeWithErrorResponse() {
        let diskPathErrorModel = DeezerAPI.album(id: 0).diskPathErrorModel
        let url = URL(fileURLWithPath: diskPathErrorModel!)
        let data = try! Data(contentsOf: url)

        let response = HTTPURLResponse(url: URL(string: "http://api.deezer.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let validator = DeezerValidator()
        let result = validator.validate(data: data, urlResponse: response, error: nil)

        XCTAssertFalse(result, "should NOT pass validation")
    }

    func testErrorStatusCodeWithNoData() {
        let response = HTTPURLResponse(url: URL(string: "http://api.deezer.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let validator = DeezerValidator()
        let result = validator.validate(data: nil, urlResponse: response, error: nil)

        XCTAssertFalse(result, "should NOT pass validation")
    }

    func testErrorStatusCodeWithCorrectData() {
        let diskPath = DeezerAPI.album(id: 0).diskPath
        let url = URL(fileURLWithPath: diskPath!)
        let data = try! Data(contentsOf: url)

        let response = HTTPURLResponse(url: URL(string: "http://api.deezer.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let validator = DeezerValidator()
        let result = validator.validate(data: data, urlResponse: response, error: nil)

        XCTAssertFalse(result, "should NOT pass validation")
    }
}
