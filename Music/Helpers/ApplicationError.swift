//
//  ApplicationError.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation
import DeezerKit

// TODO
enum ApplicationError: Error {
    case someError
    case deezerError(DeezerError)
}
