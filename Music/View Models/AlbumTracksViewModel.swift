//
//  AlbumViewModel.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

struct AlbumTracksViewModel {
    let id: Int
    let tracks: [[TrackViewModel]]
}

struct TrackViewModel {
    let title: String
    let trackNumber: Int
}
