//
//  SearchFlowControllerViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

class SearchFlowController: UIViewController {
    private lazy var dependencies = AppDependencies()

    private lazy var searchViewController: SearchViewController = {
        let search = SearchViewController(dependencies: dependencies)
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
    
    func showArtist(_ id: Int) {
        
    }
    
    func showAlbum(_ id: Int) {
        
    }
}
