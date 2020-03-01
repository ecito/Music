//
//  SearchDataSource.swift
//  Music
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit
import DeezerKit

class SearchDataSource {
    private var cancellableSearch: Cancellable?
    private var pendingRequestWorkItem: DispatchWorkItem?
    private var dependencies: HasDeezerService
    private var tableView: UITableView
    
    public var debounceMilliseconds: Int = 500
    
    public init(dependencies: HasDeezerService, tableView: UITableView) {
        self.dependencies = dependencies
        self.tableView = tableView
    }
    
    lazy var tableViewDataSource: UITableViewDiffableDataSource<SearchSection, SearchDatum> = {
        return UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, searchItem in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(searchItem.name)"
            return cell
        }
    }()
    
    private func showEmptyTable() {
        tableViewDataSource.apply(NSDiffableDataSourceSnapshot<SearchSection, SearchDatum>(),
                                       animatingDifferences: false)
    }
    
    private func showSearchItems(_ items: [SearchDatum]) {
        var snapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchDatum>()
        snapshot.appendSections(SearchSection.allCases)
        snapshot.appendItems(items)
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    public func cancelSearch() {
        cancellableSearch?.cancel()
        pendingRequestWorkItem?.cancel()
    }
    
    public func search(_ text: String, completion: ((Result<Void, DeezerError>) -> Void)? = nil) {
        cancelSearch()
        
        guard text.count > 1 else {
            showEmptyTable()
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
