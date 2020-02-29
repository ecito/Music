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
    case searchArtists(text: String)
    case albumsForArtist(id: Int)
    case album(id: Int)
    case tracksForAlbum(id: Int)
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
        case .searchArtists:
            return "search/artist"
        case .albumsForArtist(let id):
            return "artist/\(id)/albums"
        case .album(let id):
            return "album/\(id)"
        case .tracksForAlbum(let id):
            return "album/\(id)/tracks"
        }
    }
    
    var queryParameters: QueryParameters? {
        switch self {
        case .searchArtists(let text):
            return QueryParameters(["q": text])
        default:
            return nil
        }
    }
    
    var diskPath: String? {
        var filename = ""

        switch self {
            
        case .searchArtists:
            filename = "search"
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
