//
//  MyPageUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities
import DomainInterfaces

public final class MyProfileUseCase: MyProfileUseCaseInterface {

    public var hasMore: Bool = false
    
    public var profilePublisher: AnyPublisher<Profile, Never> {
        return profileSubject.eraseToAnyPublisher()
    }
    
    public var storyListPubliser: AnyPublisher<[MyPageStory], Never> {
        return storyListSubject.eraseToAnyPublisher()
    }
    
    private let repository: MyProfileRepositoryInterface
    private let storyListSubject = PassthroughSubject<[MyPageStory], Never>()
    private let profileSubject = PassthroughSubject<Profile, Never>()
    private var storyOffset = 0
    private let pageLimit = 10
    
    public init(repository: MyProfileRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchMyProfile() async -> Result<Profile, Error> {
        let result = await repository.fetchMyProfile()
        updateProfile(result)
        updateStoryList(result)
        return result
    }
        
    public func fetchProfileStory(id: Int) async -> Result<[MyPageStory], Error> {
        storyOffset = 0
        return await fetchMyProfileStory(id: id, offset: storyOffset)
    }
    
    public func loadMoreProfileStory(id: Int) async -> Result<[MyPageStory], Error> {
        storyOffset += 1
        return await fetchMyProfileStory(id: id, offset: storyOffset)
    }
     
    private func fetchMyProfileStory(id: Int, offset: Int) async -> Result<[MyPageStory], Error> {
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
    
    public func fetchUserMedtaData() async -> Result<ProfileUpdateMetaData, Error> {
        await repository.fetchUserMedtaData()
    }
    
    public func patchUserUpdate(userUpdate: UserUpdateContent) async -> Result<Int, Error> {
        await repository.patchUserUpdate(userUpdate: userUpdate)
    }
    
    public func requestResign(message: String) async -> Result<Void, Error> {
        await repository.requestResign(message: message)
    }
    
    public func requestFollow(userId: Int) async -> Result<Void, Error> {
        await repository.requestFollow(userId: userId)
    }
    
    public func requestUnfollow(userId: Int) async -> Result<Void, Error> {
        await repository.requestUnfollow(userId: userId)
    }
    
    public func checkUsername(username: String) async -> Result<Void, Error> {
        await repository.checkUsername(username: username)
    }
    
    public func fetchFollowers() async -> Result<[SearchUser], Error> {
        await repository.requestFollowers()
    }
    
    public func fetchFollowings() async -> Result<[SearchUser], Error> {
        await repository.requestFollowings()
    }
}
