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
    public let profileUrl: String
    
    public init(userId: Int, username: String, profileUrl: String) {
        self.userId = userId
        self.username = username
        self.profileUrl = profileUrl
    }
    
}
