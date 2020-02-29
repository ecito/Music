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
    
    func testGetArtistAlbums() {
        let expectation = XCTestExpectation(description: "should get albums response")

        service.network
            .request(DeezerAPI.albumsForArtist(id: 1))
            .responseDecoded(of: ArtistAlbums.self, errorType: ErrorModel.self) { response in
            
                switch response.result {
                case let .success(albums):
                    XCTAssertEqual(albums.data.count, 25, "should have 25 album results")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetAlbum() {
        let expectation = XCTestExpectation(description: "should get album response")

        service.network
            .request(DeezerAPI.album(id: 1))
            .responseDecoded(of: Album.self, errorType: ErrorModel.self) { response in
            
                switch response.result {
                case let .success(album):
                    XCTAssertEqual(album.title, "Arabesuku", "should have title of Arabesuku")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetAlbumTracks() {
        let expectation = XCTestExpectation(description: "should get album tracks response")
        
        service.network
            .request(DeezerAPI.tracksForAlbum(id: 1))
            .responseDecoded(of: Tracks.self, errorType: ErrorModel.self) { response in
                
                switch response.result {
                case let .success(tracks):
                    XCTAssertEqual(tracks.data.count, 4, "should have 4 tracks")
                    expectation.fulfill()
                case let .failure(error):
                    XCTFail("got network error \(error)")
                }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testErrorResponse() {
        let expectation = XCTestExpectation(description: "should get search response")

        service.network
            .request(DeezerAPI.searchArtists(text: "eminem"))
            .validate(with: FailValidator()) // force a failure so we get an ErrorModel
            .responseDecoded(of: Search.self, errorType: ErrorModel.self) { response in
            print(response)
                switch response.result {
                case .success:
                    XCTFail("should get an error")
                case let .failure(error):
                    print(error)
                    if case let .errorResponse(model) = error,
                        let errorModel = model as? ErrorModel {
                        XCTAssertEqual(errorModel.code, 800, "should have error code 2")
                    }
                    else {
                        XCTFail("should have an error model")
                    }
                    expectation.fulfill()
                }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
