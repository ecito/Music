//
//  DeezerUIService.swift
//  Music
//
//  Created by Andre Navarro on 3/3/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

protocol ViewControllerFactory {
    func makeMainTabBarController() -> UITabBarController
    func makeHomeFlowController() -> HomeFlowController

    func makeSearchFlowController() -> SearchFlowController
    func makeAlbumsForArtistViewController(_ artist: SearchDatum) -> ArtistViewController
    func makeAlbumViewController(_ album: AlbumViewModel) -> AlbumViewController

    func makeDeezerCollectionView(_ viewModels: [DeezerCollectionItemSectionViewModel]) -> DeezerItemCollectionViewController
}

extension AppDependencies: ViewControllerFactory {
    func makeMainTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [makeSearchFlowController(), makeHomeFlowController()]
        tabBar.viewControllers?[0].tabBarItem.title = "Search"
        tabBar.viewControllers?[1].tabBarItem.title = "Home"
        return tabBar
    }

    func makeHomeFlowController() -> HomeFlowController {
        return HomeFlowController(dependencies: self)
    }

    func makeSearchFlowController() -> SearchFlowController {
        SearchFlowController(dependencies: self)
    }

    func makeAlbumsForArtistViewController(_ artist: SearchDatum) -> ArtistViewController {
        let artistViewController = ArtistViewController(dependencies: self)

        artistViewController.setLoadingState(.initial(preValue: artist))

        self.deezerService.getAlbumsForArtist(artist.id) { result in
            switch result {
            case let .success(albums):
                let viewModel = self.albumsViewModelFor(artist, artistAlbums: albums)
                artistViewController.setLoadingState(.loaded(value: viewModel))
            case let .failure(error):
                artistViewController.setLoadingState(.failed(error: .deezerError(error)))
            }
        }

        return artistViewController
    }

    func makeAlbumViewController(_ album: AlbumViewModel) -> AlbumViewController {
        let albumViewController = AlbumViewController()

        albumViewController.setLoadingState(.initial(preValue: album))

        self.deezerService.getTracksForAlbum(album.id) { result in
            switch result {
            case let .success(tracks):
                let viewModel = self.albumTracksViewModelFor(album, tracks: tracks)
                albumViewController.setLoadingState(.loaded(value: viewModel))
            case let .failure(error):
                albumViewController.setLoadingState(.failed(error: .deezerError(error)))
            }
        }

        return albumViewController
    }

    func makeDeezerCollectionView(_ viewModels: [DeezerCollectionItemSectionViewModel]) -> DeezerItemCollectionViewController {

            let collection = DeezerItemCollectionViewController(viewType: UIImageView.self,
                                                                sectionTitleViewType: UILabel.self,
                                                                layout: DeezerItemCollectionViewController.deezerLayout())

            collection.numberOfItems = { viewModels[$0].items.count }
            collection.numberOfSections = { viewModels.count }
            collection.configureView = { indexPath, view in
                let item = viewModels[indexPath.section].items[indexPath.row]
                view.loadImage(from: item.imageURL)
            }
            collection.configureTitle = { indexPath, view in
                let section = viewModels[indexPath.section]
                view.text = section.title
            }
            collection.didSelectView = { indexPath, view in
                print(indexPath)
            }

            return collection
    }
}
