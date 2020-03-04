//
//  ViewModelFactory.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import DeezerKit

protocol ViewModelFactory {
    func albumsViewModelFor(_ artist: SearchDatum, artistAlbums: ArtistAlbums) -> ArtistAlbumsViewModel
}

extension AppDependencies: ViewModelFactory {
    func albumsViewModelFor(_ artist: SearchDatum, artistAlbums: ArtistAlbums) -> ArtistAlbumsViewModel {
        let albums = artistAlbums.data.map { datum in
            AlbumViewModel(imageURL: datum.cover, title: datum.title)
        }
        
        return ArtistAlbumsViewModel(title: artist.name, imageURL: artist.pictureXl ?? artist.picture, albums: albums)
    }
}
