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

    public func searchArtistsWith(text: String, completion: @escaping (Result<Search, DeezerError>) -> Void) {
        performNetworkRequest(DeezerAPI.searchArtists(text: text),
                              responseType: Search.self,
                              completion: completion)
    }
    
    public func getAlbumsForArtist(_ id: Int, completion: @escaping (Result<ArtistAlbums, DeezerError>) -> Void) {
        performNetworkRequest(DeezerAPI.albumsForArtist(id: id),
                              responseType: ArtistAlbums.self,
                              completion: completion)
    }
    
    public func getAlbum(_ id: Int, completion: @escaping (Result<Album, DeezerError>) -> Void) {
        performNetworkRequest(DeezerAPI.album(id: id),
                              responseType: Album.self,
                              completion: completion)
    }
    
    public func getTracksForAlbum(_ id: Int, completion: @escaping (Result<Tracks, DeezerError>) -> Void) {
        performNetworkRequest(DeezerAPI.tracksForAlbum(id: id),
                              responseType: Tracks.self,
                              completion: completion)
    }
    
    internal func performNetworkRequest<T: Decodable>(_ target: TargetType,
                                             responseType: T.Type = T.self,
                                             shouldFail: Bool = false, // for tests
                                             completion: @escaping (Result<T, DeezerError>) -> Void) {
        
        network
            .request(target)
            .validate(with: shouldFail ? FailValidator() : DeezerValidator())
            .responseDecoded(of: responseType, errorType: DeezerAPIError.self) { response in
                
                let result = response.result.mapError { networkError -> DeezerError in
                    if case let .errorResponse(errorModel) = networkError,
                        let apiError = errorModel as? DeezerAPIError {
                        return DeezerError.apiError(apiError)
                    }
                    else {
                        return DeezerError.networkError(networkError)
                    }
                }
                
                completion(result)
        }
    }    
}
