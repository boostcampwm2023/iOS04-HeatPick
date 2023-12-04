//
//  StoryUseCase.swift
//  DomainUseCases
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import CoreKit
import DomainEntities
import DomainInterfaces
import NetworkAPIKit

public final class StoryUseCase: StoryUseCaseInterface {
    
    private let repository: StoryRepositoryInterface
    private let locationService: LocationServiceInterface
    
    public init(repository: StoryRepositoryInterface, locationService: LocationServiceInterface) {
        self.repository = repository
        self.locationService = locationService
    }
    
    public func requestAddress(of location: Location) async -> Result<String?, Error> {
        do {
            let address = try await locationService.requestAddress(lat: location.lat, lng: location.lng)
            return .success(address)
        } catch {
            return .failure(error)
        }
    }
    
    public func requestMetaData() async -> Result<([StoryCategory], [Badge]), Error> {
        return await repository.requestMetaData()
    }
    
    public func requestCreateStory(storyContent: StoryContent) async -> Result<Story, Error> {
        return await repository.requestCreateStory(storyContent: storyContent)
    }
    
    public func requestStoryDetail(storyId: Int) async -> Result<Story, Error> {
        return await repository.requestStoryDetail(storyId: storyId)
    }
    
    public func requestFollow(userId: Int) async -> Result<Void, Error> {
        return await repository.requestFollow(userId: userId)
    }
    
    public func requestUnfollow(userId: Int) async -> Result<Void, Error> {
        return await repository.requestUnfollow(userId: userId)
    }
    
    public func requestReadComment(storyId: Int) async -> Result<[Comment], Error> {
        return await repository.requestReadComment(storyId: storyId)
    }
    
    public func requestNewComment(content: CommentContent) async -> Result<Void, Error> {
        return await repository.requestNewComment(content: content)
    }
    
    public func requestLike(storyId: Int) async -> Result<Int, Error> {
        return await repository.requestLike(storyId: storyId)
    }
    public func requestUnlike(storyId: Int) async -> Result<Int, Error> {
        return await repository.requestUnlike(storyId: storyId)
    }
}
