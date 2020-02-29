//
//  DeezerError.swift
//  Music
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

enum DeezerError: Error {
    case quota
    case itemsLimitExceeded
    case permission
    case tokenInvalid
    case parameter
    case parameterMissing
    case queryInvalid
    case serviceBusy
    case dataNotFound
}

/*
 https://developers.deezer.com/api/errors
 
 QUOTA    Exception    4
 ITEMS_LIMIT_EXCEEDED    Exception    100
 PERMISSION    OAuthException    200
 TOKEN_INVALID    OAuthException    300
 PARAMETER    ParameterException    500
 PARAMETER_MISSING    MissingParameterException    501
 QUERY_INVALID    InvalidQueryException    600
 SERVICE_BUSY    Exception    700
 DATA_NOT_FOUND    DataException    800

 */
