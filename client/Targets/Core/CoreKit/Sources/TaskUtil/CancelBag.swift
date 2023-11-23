//
//  CancelBag.swift
//  CoreKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine

public final class CancelBag {
    
    private var cancellables: [AnyCancellableTask] = []
    
    public init() {}
    
    public func store(task: AnyCancellableTask) {
        cancellables.append(task)
    }
    
    public func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    deinit { cancel() }
    
}

extension Task {
    
    public func store(in bag: CancelBag) {
        bag.store(task: self)
    }
    
}
