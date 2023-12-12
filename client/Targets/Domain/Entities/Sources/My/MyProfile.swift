//
//  MyPageProfile.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MyProfile {
    
    public let userId: Int
    public let userName: String
    public let profileImageURL: String?
    public let temperature: Int
    public let temperatureFeeling: String
    public let followerCount: Int
    public let storyCount: Int
    public let experience: Int
    public let maxExperience: Int
    public let mainBadge: MyPageBadge
    
    public init(profile: Profile) {
        self.userId = profile.userId
        self.userName = profile.userName
        self.profileImageURL = profile.profileImageURL
        self.temperature = profile.temperature
        self.temperatureFeeling = profile.temperatureFeeling
        self.followerCount = profile.followerCount
        self.storyCount = profile.storyCount
        self.experience = profile.experience
        self.maxExperience = profile.maxExperience
        self.mainBadge = profile.mainBadge
    }
    
}
