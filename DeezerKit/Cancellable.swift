//
//  Cancellable.swift
//  Music
//
//  Created by Andre Navarro on 3/1/20.
//  Copyright © 2020 DML. All rights reserved.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

class NonCancellable: Cancellable {
    func cancel() {}
}

class BlockCancellable: Cancellable {
    private var handler: (() -> Void)?

    public init(_ handler: @escaping () -> Void) {
        self.handler = handler
    }

    private let lock: NSRecursiveLock = {
        let lock = NSRecursiveLock()
        lock.name = "to.eci.Music.cancel_lock"
        return lock
    }()

    public var isCancelled: Bool {
        lock.lock(); defer { lock.unlock() }
        return handler == nil
    }

    public func cancel() {
        lock.lock()
        guard let handler = handler else {
            lock.unlock()
            return
        }
        self.handler = nil
        lock.unlock()
        handler()
    }
}
