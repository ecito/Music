//
//  StateViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

// do we really need this? not really hmmmm 
public final class StateViewController: UIViewController, HasLoadingState {
    typealias PreLoadingValue = String
    typealias LoadingValue = UIViewController
    typealias LoadingError = ApplicationError

    var loadingViewController: UIViewController { LoadingViewController() }

    private var contentController: UIViewController? {
        didSet {
            guard contentController != oldValue else { return }

            swapContent(newValue: contentController, oldValue: oldValue)
        }
    }

    private func viewController(for state: LoadingState<String, UIViewController, ApplicationError>) -> UIViewController {
        switch state {
        case .initial:
            return loadingViewController
        case .loading:
            fallthrough
        case .reloading:
            return loadingViewController
        case .loaded(let viewController):
            return viewController
        case .failed(let error):
            print(error)
            return loadingViewController
        }
    }

    func setLoadingState(_ state: LoadingState<String, UIViewController, ApplicationError>) {
        contentController = viewController(for: state)
    }

    private func swapContent(newValue: UIViewController?, oldValue: UIViewController?) {
        oldValue?.view.removeFromSuperview()
        oldValue?.removeFromParent()
        oldValue?.didMove(toParent: nil)

        guard let controller = newValue else { return }

        install(controller)
    }

    public override func loadView() {
        view = UIView()
        contentController = loadingViewController
    }

}
