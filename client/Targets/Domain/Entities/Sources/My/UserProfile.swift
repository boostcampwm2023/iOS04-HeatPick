//
//  UserProfile.swift
//  DomainEntities
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserProfile {
    
    public let userId: Int
    public let userName: String
    public let profileImageURL: String?
    public let isFollow: Bool
    public let temperature: Double
    public let temperatureFeeling: String
    public let followerCount: Int
    public let followingCount: Int
    public let storyCount: Int
    public let experience: Int
    public let maxExperience: Int
    public let mainBadge: MyPageBadge
    
    public init(profile: Profile) {
        self.userId = profile.userId
        self.userName = profile.userName
        self.profileImageURL = profile.profileImageURL
        self.isFollow = profile.isFollow
        self.temperature = profile.temperature
        self.temperatureFeeling = profile.temperatureFeeling
        self.followerCount = profile.followerCount
        self.followingCount = profile.followingCount
        self.storyCount = profile.storyCount
        self.experience = profile.experience
        self.maxExperience = profile.maxExperience
        self.mainBadge = profile.mainBadge
    }
    
}
