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
    func makeAlbumsForArtistViewController(_ id: Int) -> StateViewController
    func makeAlbumViewController(_ id: Int) -> StateViewController
}

extension AppDependencies: ViewControllerFactory {
    func makeSearchFlowController() -> SearchFlowController {
        SearchFlowController(dependencies: self)
    }
    
    func makeAlbumsForArtistViewController(_ id: Int) -> StateViewController {
        let stateViewController = StateViewController()
                
        self.deezerService.getAlbumsForArtist(id) { result in
            switch result {
            case let .success(albums):
                let albumsViewController = AlbumsViewController()
                stateViewController.state = .content(controller: albumsViewController)
            case let .failure(error):
                stateViewController.state = .error(message: "error: \(error)")
                break
            }
        }
        
        return stateViewController
    }
    
    func makeAlbumViewController(_ id: Int) -> StateViewController {
        return StateViewController()
    }
}
