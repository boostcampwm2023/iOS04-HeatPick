//
//  FollowListResponseDTO.swift
//  MyAPI
//
//  Created by jungmin lim on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct FollowListResponseDTO: Decodable {
    
    public let users: [FollowUserResponseDTO]
    
    public init(users: [FollowUserResponseDTO]) {
        self.users = users
    }
    
    public struct FollowUserResponseDTO: Decodable {
        public let userId: Int
        public let username: String
        public let profileUrl: String
        
        public init(userId: Int, username: String, profileUrl: String) {
            self.userId = userId
            self.username = username
            self.profileUrl = profileUrl
        }
        
        public func toDomain() -> SearchUser {
            .init(userId: userId, username: username, profileUrl: profileUrl)
        }
    }

    public func toDomain() -> [SearchUser] {
        users.map { $0.toDomain() }
    }
}
