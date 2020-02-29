//
//  DeezerError.swift
//  Music
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import NetworkKit

enum DeezerError: Error {
    case networkError(NetworkError)
    case apiError(DeezerAPIError)
}
