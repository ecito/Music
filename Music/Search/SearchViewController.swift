//
//  SearchViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

class SearchViewController: UITableViewController {
    var dependencies: HasDeezerService

    init(dependencies: HasDeezerService) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        return search
    }()

    lazy var searchDataSource = SearchDataSource(dependencies: dependencies,
                                                 tableView: tableView,
                                                 cellProvider: cellProvider)

    lazy var didSelectItem: (SearchDatum, IndexPath) -> Void = { _, _ in }

    lazy var cellProvider: SearchDiffableDataSource.CellProvider = { tableView, indexPath, searchItem in
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchDataSource.cellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(searchItem.name)"
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchDataSource.cellIdentifier)
        tableView.dataSource = searchDataSource.tableViewDataSource
        navigationItem.searchController = searchController
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = searchDataSource.searchItems
        let searchItem = items[indexPath.row]
        didSelectItem(searchItem, indexPath)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        searchDataSource.loadMoreIfNeeded(with: indexPath)
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
