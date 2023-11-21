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
    
    public init(repository: HomeRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchRecommendPlace(lat: Double, lon: Double) async -> Result<[RecommendStory], Error> {
        return await repository.fetchRecommendPlace(lat: lat, lon: lon)
    }
    
    public func fetchHotPlace() async -> Result<[RecommendStory], Error> {
        return await repository.fetchHotPlace()
    }
    
}
