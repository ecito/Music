//
//  ChartViewModel.swift
//  Music
//
//  Created by Andre Navarro on 3/6/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

protocol ChartViewModel: DeezerCollectionItemSectionViewModel { }

struct ChartTracksViewModel: ChartViewModel {
    var title = "Tracks"
    var items: [DeezerCollectionItemViewModel]
}

struct ChartAlbumsViewModel: ChartViewModel {
    var title = "Albums"
    var items: [DeezerCollectionItemViewModel]
}

struct ChartArtistsViewModel: ChartViewModel {
    var title = "Artists"
    var items: [DeezerCollectionItemViewModel]
}

struct ChartPlaylistsViewModel: ChartViewModel {
    var title = "Playlists"
    var items: [DeezerCollectionItemViewModel]
}

struct ChartTrackViewModel: DeezerCollectionItemViewModel {
    var imageURL: String
    var title: String
    var trackNumber: Int
    let link: String?
}

struct ArtistViewModel: DeezerCollectionItemViewModel {
    var imageURL: String
    var title: String
    let link: String?
}

struct PlaylistViewModel: DeezerCollectionItemViewModel {
    var imageURL: String
    var title: String
    let link: String?
}
