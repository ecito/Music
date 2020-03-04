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
    func makeAlbumsForArtistViewController(_ artist: SearchDatum) -> StateViewController
    func makeAlbumViewController(_ id: Int) -> StateViewController
}

extension AppDependencies: ViewControllerFactory {
    func makeSearchFlowController() -> SearchFlowController {
        SearchFlowController(dependencies: self)
    }
    
    func makeAlbumsForArtistViewController(_ artist: SearchDatum) -> StateViewController {
        // hmmm do we really wanna have a separate view controller for loading state? hmmm
        let stateViewController = StateViewController()
        let contentViewController = ArtistViewController()
        let stretchyViewController = StretchyHeaderScrollViewController(contentViewController)
        
        stretchyViewController.titleLabel.text = artist.name
        stretchyViewController.headerImageView.loadImage(from: artist.pictureXl ?? artist.picture)

        func refresh() {
            self.deezerService.getAlbumsForArtist(artist.id) { result in
                switch result {
                case let .success(albums):
                    contentViewController.show(self.albumsViewModelFor(artist, artistAlbums: albums))
                    stateViewController.state = .content(controller: stretchyViewController)
                case let .failure(error):
                    print(error)
                    stateViewController.state = .error(message: "error: \(error)")
                    break
                }
            }
        }

        // just trying to think how to handle refresh/retry if we take the data fetching out of the view controller
        refresh()

        return stateViewController
    }
    
    func makeAlbumViewController(_ id: Int) -> StateViewController {
        return StateViewController()
    }
}
