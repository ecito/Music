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
