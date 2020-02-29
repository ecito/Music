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
    public let network: NetworkType
    init(network: NetworkType) {
        self.network = network
    }
    
    func searchArtistsWith(text: String, completion: @escaping (Result<Search, DeezerError>) -> Void) {
        network
            .request(DeezerAPI.searchArtists(text: text))
            .validate(with: DeezerValidator())
            .responseDecoded(of: Search.self, errorType: DeezerAPIError.self) { response in
                let result = response.result
                    .mapError { networkError -> DeezerError in
                        if case let .responseError(errorModel) = networkError,
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
    
    func getAlbumsForArtist(_ id: Int) {
        
    }
    
    func getAlbum(_ id: Int) {
        
    }
    
    func getTracksForAlbum(_ id: Int) {
        
    }
}
