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
typealias SearchDiffableSnapShot = NSDiffableDataSourceSnapshot<SearchSection, SearchDatum>

public class SearchDataSource {
    private var cancellableSearch: Cancellable?
    private var pendingRequestWorkItem: DispatchWorkItem?
    private var dependencies: HasDeezerService
    private var tableView: UITableView
    private var cellProvider: SearchDiffableDataSource.CellProvider

    public static var cellIdentifier = "Cell"
    public var searchLimit: Int = 25
    public static var debounceMilliseconds: Int = 200

    public var lastSearchText: String?
    public var lastSearch: Search?
    public var lastIndex: Int = 0

    public var searchItems = [SearchDatum]()

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

    private func showSearchItems(_ items: [SearchDatum]) {
        searchItems = searchItems + items
        apply(items)
    }

    private func apply(_ items: [SearchDatum]) {
        var snapshot = tableViewDataSource.snapshot()

        if snapshot.numberOfSections == 0 {
            snapshot.appendSections(SearchSection.allCases)
        }

        snapshot.appendItems(items)
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }

    private func clear() {
        lastSearchText = nil
        lastSearch = nil
        lastIndex = 0
        searchItems = [SearchDatum]()
        tableViewDataSource.apply(SearchDiffableSnapShot(),
                                  animatingDifferences: false)
    }

    public func cancelSearch() {
        cancellableSearch?.cancel()
        pendingRequestWorkItem?.cancel()
    }

    public func search(_ text: String,
                       index: Int? = nil,
                       completion: ((Result<Void, DeezerError>) -> Void)? = nil) {
        guard text.count > 1 else {
            clear()
            return
        }

        // if we try to search the same text with no index then something is wrong
        guard !(lastSearchText == text && index == nil) else {
            return
        }

        // this is a new search so clear all our state
        if lastSearchText != text {
            clear()
        }

        startSearch(text, index: index) { result in
            switch result {
            case let .success(search):
                self.lastIndex = self.lastIndex + search.data.count
                self.lastSearch = search
                self.lastSearchText = text
                self.showSearchItems(search.data)
            case let .failure(error):
                print("did error search \(error)")
            }

            completion?(result.map { _ in () })
        }
    }

    private func startSearch(_ text: String,
                               index: Int? = nil,
                               completion: @escaping (Result<Search, DeezerError>) -> Void) {
        cancelSearch()

        pendingRequestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else {
                return
            }

            self.cancellableSearch =
                self.dependencies.deezerService
                    .searchArtistsWith(text: text,
                                       index: index,
                                       limit: self.searchLimit) { result in
                                        self.cancellableSearch = nil

                                        completion(result)
            }
        }

        // debounce
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Self.debounceMilliseconds),
                                      execute: pendingRequestWorkItem!)
    }

    func loadMoreIfNeeded(with indexPath: IndexPath) {
        guard let text = lastSearchText else {
            return
        }

        guard let _ = lastSearch?.next else {
            return
        }

        if searchItems.count == indexPath.row + 1 {
            search(text, index: lastIndex)
        }
    }
}
