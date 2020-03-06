//
//  AlbumViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, HasLoadingState {
    typealias PreLoadingValue = AlbumViewModel
    typealias LoadingValue = AlbumTracksViewModel
    typealias LoadingError = ApplicationError
    
    lazy var tracksTableViewController = TracksTableViewController()
    lazy var titleView = StretychHeaderTitleView()
    lazy var stretchyViewController = StretchyHeaderScrollViewController(headerView: titleView)
        
    override func loadView() {
        view = UIView()
        install(stretchyViewController)
    }
    
    func setLoadingState(_ state: LoadingState<AlbumViewModel, AlbumTracksViewModel, ApplicationError>) {
        switch state {
        case let .initial(album):
            titleView.titleLabel.text = album.title
            stretchyViewController.headerImageView.loadImage(from: album.imageURL)
        case .loading:
            // show a spinner? for example
            break
        case .reloading:
            break
        case let .loaded(tracks):
            tracksTableViewController.show(tracks.tracks)
        case .failed(let error):
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
}
