//
//  Dependencies.swift
//  Music
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import DeezerKit
import NetworkKit

/// Union of protocols that different parts of the app can depend on
typealias AllDependencies = HasNetwork & HasDeezerService

/// All the app's dependencies in one place
class AppDependencies: AllDependencies {
    lazy var network: NetworkType = Network()
    lazy var deezerService = DeezerService(network: network)
}

protocol HasNetwork {
    var network: NetworkType { get }
}

protocol HasDeezerService {
    var deezerService: DeezerService { get }
}
