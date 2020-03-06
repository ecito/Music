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
    func albumTracksViewModelFor(_ album: AlbumViewModel, tracks: Tracks) -> AlbumTracksViewModel
    func chartViewModelFor(_ chart: Chart) -> [ChartViewModel]
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
    
    func chartViewModelFor(_ chart: Chart) -> [ChartViewModel] {
            let viewModels: [ChartViewModel] =
                [ChartTracksViewModel(items: chart.tracks.data.map {
                    ChartTrackViewModel(imageURL: $0.artist.pictureBig ?? $0.artist.picture ?? "",
                                        title: $0.title,
                                        trackNumber: $0.trackPosition ?? 0)
                }),
                 ChartAlbumsViewModel(items: chart.albums.data.map {
                    AlbumViewModel(id: $0.id,
                                   imageURL: $0.coverBig ?? $0.cover,
                                   title: $0.title)
                 }),
                 ChartArtistsViewModel(items: chart.artists.data.map {
                    ArtistViewModel(imageURL: $0.picture ?? "", title: $0.name)
                 }),
                 ChartPlaylistsViewModel(items: chart.playlists.data.map {
                    PlaylistViewModel(imageURL: $0.pictureBig ?? $0.picture, title: $0.title)
                 })
            ]
            
            return viewModels
    }
}
