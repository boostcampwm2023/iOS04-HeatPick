//
//  UserRecommend.swift
//  DomainEntities
//
//  Created by 홍성준 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserRecommend {
    
    public let userId: Int
    public let username: String
    public let profileUrl: String?
    
    public init(userId: Int, username: String, profileUrl: String?) {
        self.userId = userId
        self.username = username
        self.profileUrl = profileUrl
    }
}
