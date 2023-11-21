//
//  HomeRepository.swift
//  DataRepositories
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import HomeAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class HomeRepository: HomeRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func fetchRecommendPlace(lat: Double, lon: Double) async -> Result<[RecommendStory], Error> {
        let target = HomeAPI.recommendLocation(lat: lat, lon: lon)
        let request: Result<RecommendLocationResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchHotPlace() async -> Result<[RecommendStory], Error> {
        let target = HomeAPI.recommend
        let request: Result<RecommendResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
}
