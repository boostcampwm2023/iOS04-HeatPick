//
//  SearchUser.swift
//  DomainEntities
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchUser {
    
    public let userId: Int
    public let username: String
    public let oauthId: String
    public let temperature: Int
    public let createAt: String
    public let deletedAt: String
    public let recentActive: String
    public let following: [String]
    public let followers: [String]
    
    public init(
        userId: Int,
        username: String,
        oauthId: String,
        temperature: Int,
        createAt: String,
        deletedAt: String,
        recentActive: String,
        following: [String],
        followers: [String]
    ) {
        self.userId = userId
        self.username = username
        self.oauthId = oauthId
        self.temperature = temperature
        self.createAt = createAt
        self.deletedAt = deletedAt
        self.recentActive = recentActive
        self.following = following
        self.followers = followers
    }
    
}
