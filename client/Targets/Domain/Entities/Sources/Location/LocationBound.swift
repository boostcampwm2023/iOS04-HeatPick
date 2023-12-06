//
//  LocationBound.swift
//  DomainEntities
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct LocationBound {
    
    public let southWest: LocationCoordinate
    public let northEast: LocationCoordinate
    
    public init(southWest: LocationCoordinate, northEast: LocationCoordinate) {
        self.southWest = southWest
        self.northEast = northEast
    }
    
}

extension LocationBound {
    
    public static func ~= (bound: LocationBound, place: Place) -> Bool {
        return (bound.southWest.lat...bound.northEast.lat) ~= place.lat &&
        (bound.southWest.lng...bound.northEast.lng) ~= place.lng
    }
    
}
