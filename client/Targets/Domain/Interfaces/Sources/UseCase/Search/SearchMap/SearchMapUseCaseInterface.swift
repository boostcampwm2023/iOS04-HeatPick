//
//  SearchMapUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine
import DomainEntities

public protocol SearchMapUseCaseInterface {
    var location: LocationCoordinate? { get }
    var recommendPlaces: AnyPublisher<[Cluster], Never> { get }
    func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<[Place], Error>
    func fetchRecommendPlace(lat: Double, lng: Double)
    func boundaryUpdated(zoomLevel: Double, boundary: LocationBound)
}
