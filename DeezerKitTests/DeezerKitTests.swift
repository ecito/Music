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
    var network = MockNetwork()

    func testSearch() {
        let expectation = XCTestExpectation(description: "should get search response")

        network
            .request(DeezerAPI.searchArtists(text: "eminem", index: nil, limit: nil))
            .responseDecoded(of: Search.self, errorType: DeezerAPIError.self) { response in
                switch response.result {
                case let .success(search):
                    XCTAssertEqual(search.data.count, 25, "should have 25 search results")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetArtistAlbums() {
        let expectation = XCTestExpectation(description: "should get albums response")

        network
            .request(DeezerAPI.albumsForArtist(id: 1, index: nil, limit: nil))
            .responseDecoded(of: ArtistAlbums.self, errorType: DeezerAPIError.self) { response in

                switch response.result {
                case let .success(albums):
                    XCTAssertEqual(albums.data.count, 25, "should have 25 album results")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetAlbum() {
        let expectation = XCTestExpectation(description: "should get album response")

        network
            .request(DeezerAPI.album(id: 1109731))
            .responseDecoded(of: Album.self, errorType: DeezerAPIError.self) { response in
                switch response.result {
                case let .success(album):
                    XCTAssertEqual(album.title, "Arabesuku", "should have title of Arabesuku")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testGetAlbumTracks() {
        let expectation = XCTestExpectation(description: "should get album tracks response")

        network
            .request(DeezerAPI.tracksForAlbum(id: 1109731, index: nil, limit: nil))
            .responseDecoded(of: Tracks.self, errorType: DeezerAPIError.self) { response in

                switch response.result {
                case let .success(tracks):
                    XCTAssertEqual(tracks.data.count, 4, "should have 4 tracks")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testErrorResponse() {
        let expectation = XCTestExpectation(description: "should get search response")

        network
            .request(DeezerAPI.album(id: -1))
            .validate(with: FailValidator()) // force a failure so we get an DeezerAPIError
            .responseDecoded(of: Search.self, errorType: DeezerAPIError.self) { response in
                switch response.result {
                case .success:
                    XCTFail("should get an error")
                case let .failure(error):
                    print(error)
                    if case let .errorResponse(model) = error,
                        let errorModel = model as? DeezerAPIError {
                        XCTAssertEqual(errorModel.code, .dataNotFound, "should have error code 800")
                    } else {
                        XCTFail("should have an error model")
                    }
                    expectation.fulfill()
                }
        }

        wait(for: [expectation], timeout: 5)
    }

    func testDeezerQueryParameters() {
        let parameters = ["query": "this"]
        let query = QueryParameters.deezerQueryParameters(parameters, index: nil, limit: nil)
        XCTAssertEqual(query?.queryItems.count, 1)
        XCTAssertEqual(query?.queryItems[0], URLQueryItem(name: "query", value: "this"))

        let indexedQuery = QueryParameters.deezerQueryParameters(parameters, index: 2, limit: 4)
        XCTAssertEqual(indexedQuery?.queryItems.count, 3)

        let firstQuery = indexedQuery?.queryItems.first(where: { $0.name == "query" })
        XCTAssertNotNil(firstQuery, "should have query Item")
        XCTAssertEqual(firstQuery?.value, "this")

        let secondQuery = indexedQuery?.queryItems.first(where: { $0.name == "index" })
        XCTAssertNotNil(secondQuery, "should have query Item")
        XCTAssertEqual(secondQuery?.value, "2")

        let thirdQuery = indexedQuery?.queryItems.first(where: { $0.name == "limit" })
        XCTAssertNotNil(thirdQuery, "should have query Item")
        XCTAssertEqual(thirdQuery?.value, "4")
    }
}
