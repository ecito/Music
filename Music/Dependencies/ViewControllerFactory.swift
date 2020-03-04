//
//  DeezerUIService.swift
//  Music
//
//  Created by Andre Navarro on 3/3/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import DeezerKit

protocol ViewControllerFactory {
    func makeSearchFlowController() -> SearchFlowController
    func makeAlbumsForArtistViewController(_ artist: SearchDatum) -> ArtistViewController
    func makeAlbumViewController(_ id: Int) -> AlbumViewController
}

extension AppDependencies: ViewControllerFactory {
    func makeSearchFlowController() -> SearchFlowController {
        SearchFlowController(dependencies: self)
    }
    
    func makeAlbumsForArtistViewController(_ artist: SearchDatum) -> ArtistViewController {
        let artistViewController = ArtistViewController()

        artistViewController.setLoadingState(.initial(preValue: artist))
        
        self.deezerService.getAlbumsForArtist(artist.id) { result in
            switch result {
            case let .success(albums):
                let viewModel = self.albumsViewModelFor(artist, artistAlbums: albums)
                artistViewController.setLoadingState(.loaded(value: viewModel))
            case let .failure(error):
                artistViewController.setLoadingState(.failed(error: error))
            }
        }

        return artistViewController
    }
    
    func makeAlbumViewController(_ id: Int) -> AlbumViewController {
        return AlbumViewController()
    }
}
