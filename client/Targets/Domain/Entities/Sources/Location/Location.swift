//
//  Location.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Location {
    
    public let lat: Double
    public let lng: Double
    public var address: String
    
    public init(lat: Double, lng: Double, address: String = "") {
        self.lat = lat
        self.lng = lng
        self.address = address
    }
    
}
