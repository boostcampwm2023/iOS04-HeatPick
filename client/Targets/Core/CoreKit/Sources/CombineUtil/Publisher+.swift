//
//  Combine+.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine

public extension Publisher {
    
    func with<O: AnyObject>(_ object: O) -> Publishers.CompactMap<Self, (O, Self.Output)> {
        return compactMap { [weak object] output in
            guard let object else { return nil }
            return (object, output)
        }
    }
    
}
