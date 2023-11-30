//
//  HomeUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainEntities
import DomainInterfaces

public final class HomeUseCase: HomeUseCaseInterface {
    
    public var hasMore: Bool {
        return !isLastPage
    }
    
    private let repository: HomeRepositoryInterface
    private let locationService: LocationServiceInterface
    private var offset = 0
    private let pageLimit = 10
    private var isLastPage = true
    
    public init(repository: HomeRepositoryInterface, locationService: LocationServiceInterface) {
        self.repository = repository
        self.locationService = locationService
    }
    
    public func fetchRecommendPlace(lat: Double, lon: Double) async -> Result<RecommendPlace, Error> {
        let locality = try? await locationService.requestLocality()
        return await repository.fetchRecommendPlace(lat: lat, lon: lon)
            .map { .init(title: locality ?? "위치를 알 수 없어요", stories: $0)}
    }
    
    public func fetchHotPlace() async -> Result<[HotPlaceStory], Error> {
        return await repository.fetchHotPlace()
            .map(\.stories)
    }
    
    public func fetchHotPlaceWithPaging() async -> Result<HotPlace, Error> {
        offset = 0
        return await fetchHotPlace(offset: offset)
    }
    
    public func loadMoreHotPlace() async -> Result<HotPlace, Error> {
        offset += 1
        return await fetchHotPlace(offset: offset)
    }
    
    private func fetchHotPlace(offset: Int) async -> Result<HotPlace, Error> {
        let result = await repository.fetchHotPlace(offset: offset, limit: pageLimit)
        switch result {
        case .success(let hotplace):
            isLastPage = hotplace.isLastPage
            
        case .failure:
            isLastPage = true
        }
        return result
    }
    
}
