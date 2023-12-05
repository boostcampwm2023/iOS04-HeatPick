//
//  UserProfileMetaDataBadge.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserProfileMetaDataBadge {
    
    public let badgeId: Int
    public let badgeName: String
    public let badgeExp: Int
    public let emoji: String
    public let badgeExplain: String
    
    public init(badgeId: Int, badgeName: String, badgeExp: Int, emoji: String, badgeExplain: String) {
        self.badgeId = badgeId
        self.badgeName = badgeName
        self.badgeExp = badgeExp
        self.emoji = emoji
        self.badgeExplain = badgeExplain
    }
    
}
