//
//  DeezerValidator.swift
//  DeezerKit
//
//  Created by Andre Navarro on 2/29/20.
//  Copyright © 2020 DML. All rights reserved.
//

import NetworkKit

struct DeezerValidator: ResponseValidator {
    func validate(data: Data?, urlResponse: URLResponse?, error: Error?) -> Bool {
        if let data = data,
            let _ = try? JSONDecoder().decode(ErrorModel.self, from: data) {
            return false
        }
        
        return DefaultResponseValidator().validate(data: data, urlResponse: urlResponse, error: error)
    }
}
