//
//  MyPageBadge.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MyPageBadge {
    
    public let id: Int
    public let name: String
    public let experience: Int
    public let emoji: String
    
    public init(id: Int, name: String, experience: Int, emoji: String) {
        self.id = id
        self.name = name
        self.experience = experience
        self.emoji = emoji
    }
    
}
