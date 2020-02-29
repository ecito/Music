//
//  DeezerService.swift
//  Music
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import NetworkKit

public class DeezerService {
    public let network: NetworkType
    init(network: NetworkType) {
        self.network = network
    }
}
