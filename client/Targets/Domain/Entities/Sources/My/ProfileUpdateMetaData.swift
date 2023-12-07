//
//  UserMetaData.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct ProfileUpdateMetaData {
 
    public let userId: Int
    public let username: String
    public let profileImageURL: String
    public let nowBadge: ProfileUpdateMetaDataBadge
    public let badges: [ProfileUpdateMetaDataBadge]
    
    public init(userId: Int, username: String, profileImageURL: String, nowBadge: ProfileUpdateMetaDataBadge, badges: [ProfileUpdateMetaDataBadge]) {
        self.userId = userId
        self.username = username
        self.profileImageURL = profileImageURL
        self.nowBadge = nowBadge
        self.badges = badges
    }
    
}

