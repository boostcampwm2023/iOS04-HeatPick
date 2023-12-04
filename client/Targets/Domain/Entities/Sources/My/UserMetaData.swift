//
//  UserMetaData.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserMetaData {
 
    public let userId: Int
    public let username: String
    public let profileURL: String?
    public let nowBadge: UserMetaDataBadge
    public let badges: [UserMetaDataBadge]
    
    public init(userId: Int, username: String, profileURL: String?, nowBadge: UserMetaDataBadge, badges: [UserMetaDataBadge]) {
        self.userId = userId
        self.username = username
        self.profileURL = profileURL
        self.nowBadge = nowBadge
        self.badges = badges
    }
    
}

