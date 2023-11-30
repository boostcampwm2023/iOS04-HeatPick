//
//  SearchMapUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchMapUseCaseInterface {
    var location: LocationCoordinate? { get }
    func fetchPlaces(lat: Double, lng: Double) async -> Result<[Place], Error>
}
