//
//  BadgeExp.swift
//  DomainEntities
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct BadgeExp {
    
    public let emoji: String
    public let name: String
    public let prevExp: Int
    public let nowExp: Int
    
    public init(emoji: String, name: String, prevExp: Int, nowExp: Int) {
        self.emoji = emoji
        self.name = name
        self.prevExp = prevExp
        self.nowExp = nowExp
    }
}
