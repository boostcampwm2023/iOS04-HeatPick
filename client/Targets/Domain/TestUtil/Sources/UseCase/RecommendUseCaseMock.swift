//
//  RecommendUseCaseMock.swift
//  DomainTestUtil
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import DomainEntities
import DomainInterfaces

public final class RecommendUseCaseMock: RecommendUseCaseInterface {
    
    public var location: LocationCoordinate?
    public var hasMoreRecommendPlace: Bool
    
    public var currentRecommendPlace: AnyPublisher<RecommendPlace, Never> {
        return currentRecommendPlaceSubject.eraseToAnyPublisher()
    }
    public var currentRecommendPlaceSubject = PassthroughSubject<RecommendPlace, Never>()
    
    public init(hasMoreRecommendPlace: Bool) {
        self.hasMoreRecommendPlace = hasMoreRecommendPlace
    }
    
    public var fetchRecommendPlaceWithPagingCallCount = 0
    public var fetchRecommendPlaceWithPagingLat: Double?
    public var fetchRecommendPlaceWithPagingLng: Double?
    public var fetchRecommendPlaceWithPagingRecommendPlace: RecommendPlace?
    public var fetchRecommendPlaceWithPagingError: Error?
    public func fetchRecommendPlaceWithPaging(lat: Double, lng: Double) async -> Result<RecommendPlace, Error> {
        fetchRecommendPlaceWithPagingCallCount += 1
        fetchRecommendPlaceWithPagingLat = lat
        fetchRecommendPlaceWithPagingLng = lng
        
        if let fetchRecommendPlaceWithPagingRecommendPlace {
            return .success(fetchRecommendPlaceWithPagingRecommendPlace)
        }
        if let fetchRecommendPlaceWithPagingError {
            return .failure(fetchRecommendPlaceWithPagingError)
        }
        fatalError("RecommendUseCaseMock fetchRecommendPlaceWithPaging 결과가 설정되지 않았습니다")
    }
    
    public var loadMoreRecommendPlaceCallCount = 0
    public var loadMoreRecommendPlaceLat: Double?
    public var loadMoreRecommendPlaceLng: Double?
    public var loadMoreRecommendPlaceRecommendPlace: RecommendPlace?
    public var loadMoreRecommendPlaceError: Error?
    public func loadMoreRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendPlace, Error> {
        loadMoreRecommendPlaceCallCount += 1
        loadMoreRecommendPlaceLat = lat
        loadMoreRecommendPlaceLng = lng
        
        if let loadMoreRecommendPlaceRecommendPlace {
            return .success(loadMoreRecommendPlaceRecommendPlace)
        }
        
        if let loadMoreRecommendPlaceError {
            return .failure(loadMoreRecommendPlaceError)
        }
        fatalError("RecommendUseCaseMock loadMoreRecommendPlace 결과가 설정되지 않았습니다")
    }
    
    public var updateCurrentLocationCallCount = 0
    public func updateCurrentLocation() {
        updateCurrentLocationCallCount += 1
    }
    
}
