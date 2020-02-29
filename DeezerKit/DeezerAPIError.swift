//
//  DeezerAPIError.swift
//  Music
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

// MARK: - Error
public struct DeezerAPIError: Error, Decodable {
    public enum Code: Int {
        case quota = 4
        case itemsLimitExceeded = 100
        case permission = 200
        case tokenInvalid = 300
        case parameter = 500
        case parameterMissing = 501
        case queryInvalid = 600
        case serviceBusy = 700
        case dataNotFound = 800
        
        case unknown
    }

    public let type: String
    public let message: String
    public let code: Code

    enum LevelUpCodingKeys: String, CodingKey {
        case error
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case message
        case code
    }
    
    public init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: LevelUpCodingKeys.self)
        let errorContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .error)
        type = try errorContainer.decode(String.self, forKey: .type)
        message = try errorContainer.decode(String.self, forKey: .message)
        let codeNumber = try errorContainer.decode(Int.self, forKey: .code)

        code = Code(rawValue: codeNumber) ?? Code.unknown
    }
}

extension DeezerAPIError: LocalizedError {
    public var errorDescription: String? {
        message
    }
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

