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

public final class MyPageUseCase: MyPageUseCaseInterface {
    
    public var hasMore: Bool = false
    
    public var profilePublisher: AnyPublisher<MyPageProfile, Never> {
        return profileSubject.eraseToAnyPublisher()
    }
    
    public var storyListPubliser: AnyPublisher<[MyPageStory], Never> {
        return storyListSubject.eraseToAnyPublisher()
    }
    
    private let repository: MyPageRepositoryInterface
    private let storyListSubject = PassthroughSubject<[MyPageStory], Never>()
    private let profileSubject = PassthroughSubject<MyPageProfile, Never>()
    private var storyOffset = 0
    private let pageLimit = 10
    
    public init(repository: MyPageRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchMyProfile() async -> Result<MyPage, Error> {
        let result = await repository.fetchMyProfile()
        updateProfile(result)
        updateStoryList(result)
        return result
    }
    
    public func fetchMyPageStory(id: Int) async -> Result<[MyPageStory], Error> {
        storyOffset = 0
        return await fetchMyPageStory(id: id, offset: storyOffset)
    }
    
    public func loadMoreMyPageStory(id: Int) async -> Result<[MyPageStory], Error> {
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
    
    private func updateProfile(_ result: Result<MyPage, Error>) {
        switch result {
        case .success(let page):
            let profile = MyPageProfile(
                userId: page.userId,
                userName: page.userName,
                profileImageURL: page.profileImageURL,
                temperature: page.temperature,
                temperatureFeeling: page.temperatureFeeling,
                followerCount: page.followerCount,
                storyCount: page.storyCount,
                experience: page.experience,
                maxExperience: page.maxExperience,
                mainBadge: page.mainBadge
            )
            profileSubject.send(profile)
            
        case .failure:
            return
        }
    }
    
    private func updateStoryList(_ result: Result<MyPage, Error>) {
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
    
    public func fetchUserMedtaData() async -> Result<UserProfileMetaData, Error> {
        await repository.fetchUserMedtaData()
    }
    
    
    public func fetchUserInfo(userUpdate: UserUpdateContent) async -> Result<Int, Error> {
        await repository.fetchUserInfo(userUpdate: userUpdate)
    }
    
    public func fetchProfile(userId: Int) async -> Result<MyPage, Error> {
        await repository.fetchProfile(userId: userId)
    }
    
}
