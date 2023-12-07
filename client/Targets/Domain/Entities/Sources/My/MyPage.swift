//
//  MyPage.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MyPage {
    
    public let userId: Int
    public let userName: String
    public let profileImageURL: String?
    public let isFollow: Bool
    public let temperature: Int
    public let temperatureFeeling: String
    public let followerCount: Int
    public let storyCount: Int
    public let experience: Int
    public let maxExperience: Int
    public let mainBadge: MyPageBadge
    public let stories: [MyPageStory]
    
    public init(userId: Int, userName: String, profileImageURL: String?, isFollow: Bool, temperature: Int, temperatureFeeling: String, followerCount: Int, storyCount: Int, experience: Int, maxExperience: Int, mainBadge: MyPageBadge, stories: [MyPageStory]) {
        self.userId = userId
        self.userName = userName
        self.profileImageURL = profileImageURL
        self.isFollow = isFollow
        self.temperature = temperature
        self.temperatureFeeling = temperatureFeeling
        self.followerCount = followerCount
        self.storyCount = storyCount
        self.experience = experience
        self.maxExperience = maxExperience
        self.mainBadge = mainBadge
        self.stories = stories
    }
    
}
