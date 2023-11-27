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
}
