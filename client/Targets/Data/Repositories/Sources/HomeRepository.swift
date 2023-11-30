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
    
    public func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendStoryWithPaging, Error> {
        let target = HomeAPI.recommendLocation(lat: lat, lng: lng)
        let request: Result<RecommendLocationResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchRecommendPlace(lat: Double, lng: Double, offset: Int, limit: Int) async -> Result<RecommendStoryWithPaging, Error> {
        let target = HomeAPI.recommendLocationSeeAll(lat: lat, lng: lng, offset: offset, limit: limit)
        let request: Result<RecommendLocationResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchHotPlace() async -> Result<HotPlace, Error> {
        let target = HomeAPI.recommend
        let request: Result<RecommendResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchHotPlace(offset: Int, limit: Int) async -> Result<HotPlace, Error> {
        let target = HomeAPI.recommendSeeAll(offset: offset, limit: limit)
        let request: Result<RecommendResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchFollowing() async -> Result<HomeFollowingStoryWithPaging, Error> {
        let target = HomeAPI.follow
        let request: Result<HomeFollowResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchFollowing(offset: Int, limit: Int, sortOption: Int) async -> Result<HomeFollowingStoryWithPaging, Error> {
        let target = HomeAPI.followWithPaging(offset: offset, limit: limit, sortOption: sortOption)
        let request: Result<HomeFollowResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
}
