//
//  Then.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol Then {}

public extension Then where Self: Any {
    
    func with(_ execute: (inout Self) throws -> Void) rethrows -> Self {
        var mutable = self
        try execute(&mutable)
        return mutable
    }
    
    func `do`(_ execute: (Self) throws -> Void) rethrows {
        try execute(self)
    }
    
}

public extension Then where Self: AnyObject {
    
    func then(_ execute: (Self) throws -> Void) rethrows -> Self {
        try execute(self)
        return self
    }
    
}

extension NSObject: Then { }
