//
//  UserMetaDataBadge.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserMetaDataBadge {
    
    public let badgeId: Int
    public let emoji: String
    public let badgeName: String
    public let badgeExp: Int
    public let badgeExplain: String
    
    public init(badgeId: Int, emoji: String, badgeName: String, badgeExp: Int,  badgeExplain: String) {
        self.badgeId = badgeId
        self.emoji = emoji
        self.badgeName = badgeName
        self.badgeExp = badgeExp
        self.badgeExplain = badgeExplain
    }
    
}
