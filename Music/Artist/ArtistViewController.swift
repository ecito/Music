//
//  ArtistViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

class ArtistViewController: UIViewController, HasLoadingState {
    typealias PreLoadingValue = SearchDatum
    typealias LoadingValue = ArtistAlbumsViewModel
    typealias LoadingError = ApplicationError
    
    lazy var albumsTableViewController = AlbumsTableViewController()
    lazy var stretchyViewController = StretchyHeaderScrollViewController(albumsTableViewController)
    
    var didSelectItem: (AlbumViewModel, IndexPath) -> () = { _, _ in } {
        didSet {
            self.albumsTableViewController.didSelectItem = didSelectItem
        }
    }
    
    override func loadView() {
        view = UIView()
        install(stretchyViewController)
    }
    
    func setLoadingState(_ state: LoadingState<SearchDatum, ArtistAlbumsViewModel, ApplicationError>) {
        switch state {
        case let .initial(artist):
            stretchyViewController.titleLabel.text = artist.name
            stretchyViewController.headerImageView.loadImage(from: artist.pictureXl ?? artist.picture)
        case .loading:
            // show a spinner? for example
            break
        case .reloading:
            break
        case .loaded(let value):
            albumsTableViewController.show(value)
        case .failed(let error):
            print(error)
        }
    }
}
