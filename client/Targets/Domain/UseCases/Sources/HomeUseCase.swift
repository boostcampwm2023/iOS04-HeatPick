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
    
    private let repository: HomeRepositoryInterface
    private let locationService: LocationServiceInterface
    
    public init(repository: HomeRepositoryInterface, locationService: LocationServiceInterface) {
        self.repository = repository
        self.locationService = locationService
    }
    
    public func fetchRecommendPlace(lat: Double, lon: Double) async -> Result<RecommendPlace, Error> {
        let locality = try? await locationService.requestLocality()
        return await repository.fetchRecommendPlace(lat: lat, lon: lon)
            .map { .init(title: locality ?? "위치를 알 수 없어요", stories: $0)}
    }
    
    public func fetchHotPlace() async -> Result<[HotPlace], Error> {
        return await repository.fetchHotPlace()
    }
    
}
