//
//  DeezerAPI.swift
//  Music
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import NetworkKit

enum DeezerAPI {
    case chart
    case searchArtists(text: String, index: Int?, limit: Int?)
    case albumsForArtist(id: Int, index: Int?, limit: Int?)
    case album(id: Int)
    case tracksForAlbum(id: Int, index: Int?, limit: Int?)
}

extension DeezerAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://api.deezer.com/")!
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        switch self {
        case .chart:
            return "chart"
        case .searchArtists:
            return "search/artist"
        case let .albumsForArtist(id, _, _):
            return "artist/\(id)/albums"
        case .album(let id):
            return "album/\(id)"
        case let .tracksForAlbum(id, _, _):
            return "album/\(id)/tracks"
        }
    }
    
    var queryParameters: QueryParameters? {
        switch self {
        case let .searchArtists(text, index, limit):
            return .deezerQueryParameters(["q": text],
                                          index: index,
                                          limit: limit)
        case let .albumsForArtist(_, index, limit):
            return .deezerQueryParameters(nil,
                                          index: index,
                                          limit: limit)

        case let .tracksForAlbum(_, index, limit):
            return .deezerQueryParameters(nil,
                                          index: index,
                                          limit: limit)
        default:
            return nil
        }
    }
    
    var diskPath: String? {
        var filename = ""

        switch self {
        case .chart:
            filename = "chart"
        case let .searchArtists(_, index, limit):
            if let index = index,
                let limit = limit {
                filename = "search-index\(index)-limit\(limit)"
            }
            else {
                filename = "search"
            }
        case .albumsForArtist:
            filename = "artist-albums"
        case .album:
            filename = "album"
        case .tracksForAlbum:
            filename = "album-tracks"
        }
        
        return Bundle.main.path(forResource: filename, ofType: "json")
    }
    
    var diskPathErrorModel: String? {
        return Bundle.main.path(forResource: "error", ofType: "json")
    }
}

extension QueryParameters {
    static func deezerQueryParameters(_ additionalParamenters: [String: Any]?, index: Int?, limit: Int?) -> QueryParameters? {
        var parameters: [String: Any] = additionalParamenters ?? [String: Any]()
        
        if let index = index {
            parameters["index"] = index
        }
        if let limit = limit {
            parameters["limit"] = limit
        }
        
        guard !parameters.isEmpty else {
            return nil
        }
        
        return QueryParameters(parameters)
    }
}
