//
//  SearchDataSource.swift
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

typealias SearchDiffableDataSource = UITableViewDiffableDataSource<SearchSection, SearchDatum>

public class SearchDataSource {
    private var cancellableSearch: Cancellable?
    private var pendingRequestWorkItem: DispatchWorkItem?
    private var dependencies: HasDeezerService
    private var tableView: UITableView
    private var cellProvider: SearchDiffableDataSource.CellProvider

    public static var cellIdentifier = "Cell"
    
    public var debounceMilliseconds: Int = 500
    
    public var searchItems = [SearchDatum]() {
        didSet {
            var snapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchDatum>()
            snapshot.appendSections(SearchSection.allCases)
            snapshot.appendItems(searchItems)
            tableViewDataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    init(dependencies: HasDeezerService,
                tableView: UITableView,
                cellProvider: @escaping SearchDiffableDataSource.CellProvider) {
        self.dependencies = dependencies
        self.tableView = tableView
        self.cellProvider = cellProvider
    }
    
    lazy var tableViewDataSource: SearchDiffableDataSource = {
        return UITableViewDiffableDataSource(tableView: tableView, cellProvider: cellProvider)
    }()
    
    public func clear() {
        searchItems = [SearchDatum]()
    }
    
    private func showSearchItems(_ items: [SearchDatum]) {
        searchItems = items
    }
    
    public func cancelSearch() {
        cancellableSearch?.cancel()
        pendingRequestWorkItem?.cancel()
    }
    
    public func search(_ text: String, completion: ((Result<Void, DeezerError>) -> Void)? = nil) {
        cancelSearch()
        
        guard text.count > 1 else {
            clear()
            return
        }

        pendingRequestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else {
                return
            }
            
            self.cancellableSearch = self.dependencies.deezerService.searchArtistsWith(text: text) { result in
                self.cancellableSearch = nil

                switch result {
                case let .success(search):
                    self.showSearchItems(search.data)
                case let .failure(error):
                    print("did error search \(error)")
                }
                
                completion?(result.map { _ in () })
            }
        }

        // debounce
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(debounceMilliseconds),
                                      execute: pendingRequestWorkItem!)
    }
}

extension SearchDatum: Hashable {
    public static func == (lhs: SearchDatum, rhs: SearchDatum) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
