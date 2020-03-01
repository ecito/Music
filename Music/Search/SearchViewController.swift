//
//  SearchViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

enum SearchSection: CaseIterable {
    case results
}

class SearchViewController: UITableViewController {
    lazy var dependencies = AppDependencies()

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        return search
    }()
    
    lazy var searchDataSource: SearchDataSource = {
        SearchDataSource(dependencies: dependencies, tableView: tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = searchDataSource.tableViewDataSource
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        searchDataSource.search(text)
    }
}
