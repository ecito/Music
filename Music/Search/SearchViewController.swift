//
//  SearchViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

extension SearchDatum: Hashable {
    public static func == (lhs: SearchDatum, rhs: SearchDatum) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum SearchSection: CaseIterable {
    case results
}

class SearchViewController: UITableViewController {
    var dependencies = Dependencies()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        return search
    }()
    
    lazy var tableViewDataSource: UITableViewDiffableDataSource<SearchSection, SearchDatum> = {
        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, searchItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(searchItem.id)"
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = tableViewDataSource
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        guard text.count > 1 else { return }
                
        dependencies.deezerService.searchArtistsWith(text: text) { result in
            switch result {
            case let .success(searchItems):
                var snapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchDatum>()
                snapshot.appendSections(SearchSection.allCases)
                snapshot.appendItems(searchItems.data)
                self.tableViewDataSource.apply(snapshot, animatingDifferences: true)
            case let .failure(error):
                print(error)
            }
        }
    }
}
