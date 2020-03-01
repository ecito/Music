//
//  AppDelegate.swift
//  Music
//
//  Created by Andre Navarro on 2/28/20.
//  Copyright © 2020 DML. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController(rootViewController: SearchViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

