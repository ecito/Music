//
//  SearchFlowControllerViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

class SearchFlowController: UIViewController {
    private var dependencies: HasDeezerService & ViewControllerFactory

    private lazy var searchViewController: SearchViewController = {
        let search = SearchViewController(dependencies: dependencies)
        search.didSelectItem = { [weak self] item, indexPath in
            self?.showAlbumsForArtist(item)
        }

        return search
    }()

    private lazy var ownedNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: searchViewController)
    }()

    init(dependencies: HasDeezerService & ViewControllerFactory) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        install(ownedNavigationController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlbumsForArtist(_ artist: SearchDatum) {
        let viewController = dependencies.makeAlbumsForArtistViewController(artist)
        viewController.didSelectItem = { [weak self] (viewModel, indexPath) in
            self?.showAlbum(viewModel)
        }
        ownedNavigationController.pushViewController(viewController, animated: true)
    }

    func showAlbum(_ album: AlbumViewModel) {
        let viewController = dependencies.makeAlbumViewController(album)
        ownedNavigationController.pushViewController(viewController, animated: true)
    }
}
