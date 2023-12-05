//
//  UserMetaData.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserProfileMetaData {
 
    public let userId: Int
    public let username: String
    public let profileImageURL: String
    public let nowBadge: UserProfileMetaDataBadge
    public let badges: [UserProfileMetaDataBadge]
    
    public init(userId: Int, username: String, profileImageURL: String, nowBadge: UserProfileMetaDataBadge, badges: [UserProfileMetaDataBadge]) {
        self.userId = userId
        self.username = username
        self.profileImageURL = profileImageURL
        self.nowBadge = nowBadge
        self.badges = badges
    }
    
}

