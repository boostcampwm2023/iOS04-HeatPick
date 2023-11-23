//
//  Author.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Author {
    public let nickname: String
    public let profileImageUrl: String?
    public let authorStatus: UserStatus
    
    public init(nickname: String, profileImageUrl: String?, authorStatus: UserStatus) {
        self.nickname = nickname
        self.profileImageUrl = profileImageUrl
        self.authorStatus = authorStatus
    }
}
