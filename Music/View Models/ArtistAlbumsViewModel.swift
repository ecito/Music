//
//  AlbumsViewModel.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

struct ArtistAlbumsViewModel {
    var title: String
    var imageURL: String
    var albums: [AlbumViewModel]
}

struct AlbumViewModel {
    var imageURL: String
    var title: String
}
