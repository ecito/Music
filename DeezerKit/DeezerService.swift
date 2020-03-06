//
//  DeezerService.swift
//  Music
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import NetworkKit

public class DeezerService {
    let network: NetworkType

    public init(network: NetworkType) {
        self.network = network
    }

    @discardableResult
    public func getChart(completion: @escaping (Result<Chart, DeezerError>) -> Void) -> Cancellable {
        performNetworkRequest(DeezerAPI.chart,
                              responseType: Chart.self,
                              completion: completion)
    }

    @discardableResult
    public func searchArtistsWith(text: String, index: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Search, DeezerError>) -> Void) -> Cancellable {
        performNetworkRequest(DeezerAPI.searchArtists(text: text, index: index, limit: limit),
                              responseType: Search.self,
                              completion: completion)
    }

    @discardableResult
    public func getAlbumsForArtist(_ id: Int, index: Int? = nil, limit: Int? = nil, completion: @escaping (Result<ArtistAlbums, DeezerError>) -> Void) -> Cancellable {
        performNetworkRequest(DeezerAPI.albumsForArtist(id: id, index: index, limit: limit),
                              responseType: ArtistAlbums.self,
                              completion: completion)
    }

    @discardableResult
    public func getAlbum(_ id: Int, completion: @escaping (Result<Album, DeezerError>) -> Void) -> Cancellable {
        performNetworkRequest(DeezerAPI.album(id: id),
                              responseType: Album.self,
                              completion: completion)
    }

    @discardableResult
    public func getTracksForAlbum(_ id: Int, index: Int? = nil, limit: Int? = nil, completion: @escaping (Result<Tracks, DeezerError>) -> Void) -> Cancellable {
        performNetworkRequest(DeezerAPI.tracksForAlbum(id: id, index: index, limit: limit),
                              responseType: Tracks.self,
                              completion: completion)
    }

    @discardableResult
    internal func performNetworkRequest<T: Decodable>(_ target: TargetType,
                                             responseType: T.Type = T.self,
                                             shouldFail: Bool = false, // for tests
                                             completion: @escaping (Result<T, DeezerError>) -> Void) -> Cancellable {

        let request = network
            .request(target)
            .validate(with: shouldFail ? FailValidator() : DeezerValidator())
            .responseDecoded(of: responseType, errorType: DeezerAPIError.self) { response in

                let result = response.result.mapError { networkError -> DeezerError in
                    if case let .errorResponse(errorModel) = networkError,
                        let apiError = errorModel as? DeezerAPIError {
                        return DeezerError.apiError(apiError)
                    } else {
                        return DeezerError.networkError(networkError)
                    }
                }

                completion(result)
        }

        return BlockCancellable {
            request.cancel()
        }
    }
}
