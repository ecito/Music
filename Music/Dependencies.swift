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

struct Dependencies {
    lazy var network: NetworkType = Network()
    lazy var deezerService = DeezerService(network: network)
}
