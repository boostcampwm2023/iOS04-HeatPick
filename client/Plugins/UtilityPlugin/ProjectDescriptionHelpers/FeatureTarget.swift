//
//  FeatureTarget.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation

public enum FeatureTarget {
    
    case staticLibrary
    case framework
    case tests
    
}

public extension Array where Element == FeatureTarget {
    var isDynamic: Bool {
        return contains(.framework)
    }
}
