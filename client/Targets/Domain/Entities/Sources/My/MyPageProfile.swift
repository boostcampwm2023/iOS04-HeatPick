//
//  MyPageProfile.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MyPageProfile {
    
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
    
    public init(userId: Int, userName: String, profileImageURL: String?, temperature: Int, temperatureFeeling: String, followerCount: Int, storyCount: Int, experience: Int, maxExperience: Int, mainBadge: MyPageBadge) {
        self.userId = userId
        self.userName = userName
        self.profileImageURL = profileImageURL
        self.temperature = temperature
        self.temperatureFeeling = temperatureFeeling
        self.followerCount = followerCount
        self.storyCount = storyCount
        self.experience = experience
        self.maxExperience = maxExperience
        self.mainBadge = mainBadge
    }
    
}
