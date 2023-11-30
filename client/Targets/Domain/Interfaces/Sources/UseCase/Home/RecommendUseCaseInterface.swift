//
//  RecommendUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities

public protocol RecommendUseCaseInterface: AnyObject {
    
    var location: LocationCoordinate? { get }
    var hasMoreRecommendPlace: Bool { get }
    var currentRecommendPlace: AnyPublisher<RecommendPlace, Never> { get }
    
    func fetchRecommendPlaceWithPaging(lat: Double, lng: Double) async -> Result<RecommendPlace, Error>
    func loadMoreRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendPlace, Error>
    func updateCurrentLocation()
    
}
