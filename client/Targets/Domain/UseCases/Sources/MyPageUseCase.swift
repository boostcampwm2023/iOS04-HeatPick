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
    
    public var profilePublisher: AnyPublisher<MyPageProfile, Never> {
        return profileSubject.eraseToAnyPublisher()
    }
    
    public var storyListPubliser: AnyPublisher<[MyPageStory], Never> {
        return storyListSubject.eraseToAnyPublisher()
    }
    
    private let repository: MyPageRepositoryInterface
    private let storyListSubject = PassthroughSubject<[MyPageStory], Never>()
    private let profileSubject = PassthroughSubject<MyPageProfile, Never>()
    
    public init(repository: MyPageRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchMyPage() async -> Result<MyPage, Error> {
        let result = await repository.fetchMyPage()
        updateProfile(result)
        updateStoryList(result)
        return result
    }
    
    private func updateProfile(_ result: Result<MyPage, Error>) {
        switch result {
        case .success(let page):
            let profile = MyPageProfile(
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
                    likeCount: story.likeCount
                )
            }
            storyListSubject.send(storyList)
            
        case .failure:
            return
        }
    }
    
}
