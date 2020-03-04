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
            AlbumViewModel(id: datum.id,imageURL: datum.coverBig ?? datum.cover, title: datum.title)
        }
        
        return ArtistAlbumsViewModel(title: artist.name, imageURL: artist.pictureXl ?? artist.picture, albums: albums)
    }
    
    func albumTracksViewModelFor(_ album: AlbumViewModel, tracks: Tracks) -> AlbumTracksViewModel {
        let tracks = tracks.data.map { track in
            TrackViewModel(title: track.title, trackNumber: track.trackPosition ?? 0)
        }
        
        // TODO: separate tracks into disks ?
        
        return AlbumTracksViewModel(id: album.id, tracks: [tracks])
    }
}
