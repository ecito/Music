//
//  Loading.swift
//  Music
//
//  Created by Andre Navarro on 3/2/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        view.backgroundColor = .red
    }
}
