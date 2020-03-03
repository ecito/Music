//
//  StateViewController.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

public final class StateViewController: UIViewController {

    public enum State {
        case loading(message: String)
        case content(controller: UIViewController)
        case error(message: String)
        case empty(message: String)
    }

    public var state: State = .loading(message: "Loading") {
        didSet {
            applyState()
        }
    }

    private var contentController: UIViewController? {
        didSet {
            guard contentController != oldValue else { return }

            swapContent(newValue: contentController, oldValue: oldValue)
        }
    }

    private func viewController(for state: State) -> UIViewController {
        switch state {
        case .loading(let _):
            return LoadingViewController()
        case .empty(let _), .error(let _):
            return LoadingViewController()
        case .content(let controller):
            return controller
        }
    }

    private func applyState() {
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

        applyState()
    }

}
