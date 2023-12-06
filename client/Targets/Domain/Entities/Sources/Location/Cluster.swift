//
//  Cluster.swift
//  DomainEntities
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Cluster {
    
    public var center: LocationCoordinate {
        return places.map { LocationCoordinate(lat: $0.lat, lng: $0.lng) }
            .reduce(.zero, +) / Double(places.count)
    }
    
    public let bound: LocationBound
    public var places: [Place]
    public var count: Int {
        return places.count
    }
    
    public init(
        bound: LocationBound,
        places: [Place] = []
    ) {
        self.bound = bound
        self.places = places
    }
    
    public func isValidRange(_ place: Place) -> Bool {
        return bound ~= place
    }
    
}

extension Cluster: Equatable {
    
    public static func == (lhs: Cluster, rhs: Cluster) -> Bool {
        return lhs.center == rhs.center && lhs.count == rhs.count
    }
    
}
