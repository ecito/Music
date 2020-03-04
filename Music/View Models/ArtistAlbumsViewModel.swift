//
//  AlbumsViewModel.swift
//  Music
//
//  Created by Andre Naletro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

struct ArtistAlbumsViewModel {
    let title: String
    let imageURL: String
    let albums: [AlbumViewModel]
}

struct AlbumViewModel {
    let id: Int
    let imageURL: String
    let title: String
}
