//
//  LocationCoordinate.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct LocationCoordinate {
    public let lat: Double
    public let lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}

extension LocationCoordinate: Hashable {
    
    public static let zero = LocationCoordinate(lat: 0, lng: 0)
    
    public static func + (lhs: LocationCoordinate, rhs: LocationCoordinate) -> LocationCoordinate {
        return .init(lat: lhs.lat + rhs.lat, lng: lhs.lng + rhs.lng)
    }
    
    public static func / (location: LocationCoordinate, div: Double) -> LocationCoordinate {
        return .init(lat: location.lat / div, lng: location.lng / div)
    }
    
}
