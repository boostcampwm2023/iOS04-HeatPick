//
//  SearchUserDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SearchUserDTO: Decodable {
    
    public let userId: Int
    public let username: String
    public let oauthId: String
    public let temperature: Int
    public let createAt: String
    public let deletedAt: String
    public let recentActive: String
    public let following: [String]
    public let followers: [String]
    
}

public extension SearchUserDTO {
    
    func toDomain() -> SearchUser {
        SearchUser(
            userId: self.userId,
            username: self.username,
            oauthId: self.oauthId,
            temperature: self.temperature,
            createAt: self.createAt,
            deletedAt: self.deletedAt,
            recentActive: self.recentActive,
            following: self.following,
            followers: self.followers
        )
    }

}
