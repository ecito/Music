//
//  LoadingState.swift
//  Music
//
//  Created by Andre Navarro on 3/4/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

enum LoadingState<PreValue, Value, Error> {
    case initial(preValue: PreValue)
    case loading
    case reloading
    case loaded(value: Value)
    case failed(error: Error)
}

protocol HasLoadingState {
    associatedtype PreLoadingValue
    associatedtype LoadingValue
    associatedtype LoadingError

    func setLoadingState(_ state: LoadingState<PreLoadingValue, LoadingValue, LoadingError>)
}
