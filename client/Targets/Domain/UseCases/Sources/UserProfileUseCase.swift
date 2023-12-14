//
//  UserProfileUseCase.swift
//  DomainUseCases
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities
import DomainInterfaces

public final class UserProfileUseCase: UserProfileUseCaseInterface {

    public var hasMore: Bool = false
    
    public var profilePublisher: AnyPublisher<Profile, Never> {
        return profileSubject.eraseToAnyPublisher()
    }
    
    public var storyListPubliser: AnyPublisher<[MyPageStory], Never> {
        return storyListSubject.eraseToAnyPublisher()
    }
    
    private let repository: UserProfileRepositoryInterface
    private let storyListSubject = PassthroughSubject<[MyPageStory], Never>()
    private let profileSubject = PassthroughSubject<Profile, Never>()
    private var storyOffset = 0
    private let pageLimit = 10
    
    public init(repository: UserProfileRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchUserProfile(userId: Int) async -> Result<Profile, Error> {
        let result = await repository.fetchUserProfile(userId: userId)
        updateProfile(result)
        updateStoryList(result)
        return result
    }
    
    public func fetchProfileStory(id: Int) async -> Result<[MyPageStory], Error> {
        storyOffset = 0
        return await fetchMyPageStory(id: id, offset: storyOffset)
    }
    
    public func loadMoreProfileStory(id: Int) async -> Result<[MyPageStory], Error> {
        storyOffset += 1
        return await fetchMyPageStory(id: id, offset: storyOffset)
    }
     
    private func fetchMyPageStory(id: Int, offset: Int) async -> Result<[MyPageStory], Error> {
        let result = await repository.fetchUserStory(id: id, offset: offset, limit: pageLimit)
        switch result {
        case .success(let stories):
            hasMore = stories.count == pageLimit
            
        case .failure:
            hasMore = false
        }
        return result
    }
    
    private func updateProfile(_ result: Result<Profile, Error>) {
        switch result {
        case let .success(profile):
            profileSubject.send(profile)
        case .failure:
            return
        }
    }
    
    private func updateStoryList(_ result: Result<Profile, Error>) {
        switch result {
        case .success(let page):
            let storyList: [MyPageStory] = page.stories.map { story in
                return MyPageStory(
                    storyId: story.storyId,
                    title: story.title,
                    content: story.content,
                    thumbnailImageURL: story.thumbnailImageURL,
                    likeCount: story.likeCount,
                    commentCount: story.commentCount
                )
            }
            storyListSubject.send(storyList)
            
        case .failure:
            return
        }
    }
    
    public func requestFollow(userId: Int) async -> Result<Void, Error> {
        await repository.requestFollow(userId: userId)
    }
    
    public func requestUnfollow(userId: Int) async -> Result<Void, Error> {
        await repository.requestUnfollow(userId: userId)
    }
    
    public func fetchFollowers(userId: Int) async -> Result<[SearchUser], Error> {
        await repository.requestFollowers(userId: userId)
    }
    
    public func fetchFollowings(userId: Int) async -> Result<[SearchUser], Error> {
        await repository.requestFollowings(userId: userId)
    }
}

