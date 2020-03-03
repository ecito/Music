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
    private lazy var dependencies = AppDependencies()

    private lazy var searchViewController: SearchViewController = {
        let search = SearchViewController(dependencies: dependencies)
        search.didSelectItem = { [weak self] item, indexPath in
            self?.showAlbumsForArtist(item.id)
        }
        
        return search
    }()

    private lazy var ownedNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: searchViewController)
    }()

    override func loadView() {
        view = UIView()
        install(ownedNavigationController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlbumsForArtist(_ id: Int) {
        let stateViewController = StateViewController()
        
        ownedNavigationController.pushViewController(stateViewController, animated: true)
        
        // show loading indicator
        dependencies.deezerService.getAlbumsForArtist(id) { result in
            switch result {
            case let .success(albums):
                let albumsViewController = AlbumsViewController()
                stateViewController.state = .content(controller: albumsViewController)
            case let .failure(error):
                stateViewController.state = .error(message: "error: \(error)")
                break
            }
        }
    }
    
    
    func showAlbum(_ id: Int) {
        
    }
}

