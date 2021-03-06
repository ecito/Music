//
//  HomeViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/5/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HasLoadingState {
    typealias PreLoadingValue = Void
    typealias LoadingValue = [ChartViewModel]
    typealias LoadingError = ApplicationError

    private var dependencies: ViewControllerFactory & ViewModelFactory

    var collectionViewController: DeezerItemCollectionViewController?

    var items = [DeezerCollectionItemSectionViewModel]()

    var didSelectItem: (DeezerCollectionItemViewModel, IndexPath) -> Void = { _, _ in }

    init(dependencies: HasDeezerService & ViewControllerFactory & ViewModelFactory) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chart"
    }

    func setLoadingState(_ state: LoadingState<PreLoadingValue, LoadingValue, LoadingError>) {
        switch state {
        case .initial:
            break
        case .loading:
            break
        case .reloading:
            break
        case let .loaded(viewModel):
            self.items = viewModel
            collectionViewController = dependencies.makeDeezerCollectionView(viewModel)
            collectionViewController?.didSelectView = { indexPath, view in
                let item = self.items[indexPath.section].items[indexPath.row]
                self.didSelectItem(item, indexPath)
            }
            install(collectionViewController!)
        case let .failed(error):
            print(error)
        }
    }
}

class HomeFlowController: UIViewController {
    private var dependencies: HasDeezerService & ViewControllerFactory & ViewModelFactory

    private lazy var homeViewController: HomeViewController = {
        let viewController = HomeViewController(dependencies: dependencies)
        viewController.didSelectItem = { [weak self] item, indexPath in
            self?.show(item)
        }
        return viewController
    }()

    private lazy var ownedNavigationController: UINavigationController = {
        return UINavigationController(rootViewController: homeViewController)
    }()

    init(dependencies: HasDeezerService & ViewControllerFactory & ViewModelFactory) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshChart()
    }

    func refreshChart() {
        homeViewController.setLoadingState(.loading)

        dependencies.deezerService.getChart { result in
            switch result {
            case let .success(chart):
                let viewModel = self.dependencies.chartViewModelFor(chart)
                self.homeViewController.setLoadingState(.loaded(value: viewModel))
            case let .failure(error):
                self.homeViewController.setLoadingState(.failed(error: .deezerError(error)))
            }
        }
    }

    func show(_ viewModel: DeezerCollectionItemViewModel) {
        print(viewModel)

        if let urlString = viewModel.link,
            let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
