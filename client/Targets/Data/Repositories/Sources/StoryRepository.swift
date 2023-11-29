//
//  StoryRepository.swift
//  DataRepositories
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import DomainEntities
import DomainInterfaces
import StoryAPI
import NetworkAPIKit

public final class StoryRepository: StoryRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func requestMetaData() async -> Result<([StoryCategory], [Badge]), Error> {
        let target = StoryAPI.metaData
        let request: Result<MetadataResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toModel() }
    }
    
    public func requestCreateStory(storyContent: StoryContent) async -> Result<Story, Error> {
        let target = StoryAPI.newStory(storyContent)
        let request: Result<NewStoryResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toDomain() }
    }
    
    public func requestStoryDetail(storyId: Int) async -> Result<Story, Error> {
        let target = StoryAPI.storyDetail(storyId)
        let request: Result<StoryDetailResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toDomain() }
    }
    
    public func requestFollow(userId: Int) async -> Result<Void, Error> {
        let target = StoryAPI.follow(userId)
        return await session.request(target)
    }
    
    public func requestUnfollow(userId: Int) async -> Result<Void, Error> {
        let target = StoryAPI.unfollow(userId)
        return await session.request(target)
    }
}
