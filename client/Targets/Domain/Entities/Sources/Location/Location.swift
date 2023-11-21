//
//  Location.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Location {
    
    public let lat: Float
    public let lng: Float
    public let address: String?
    
    public init(lat: Float, lng: Float, address: String?) {
        self.lat = lat
        self.lng = lng
        self.address = address
    }
    
}
