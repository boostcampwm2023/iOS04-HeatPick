//
//  UserMetaDataResponseDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainEntities

public struct UserMetaDataResponseDTO: Decodable {
    public let userId: Int
    public let username: String
    public let profileURL: String
    public let nowBadge: UserMetaDataBadgeResponseDTO
    public let badges: [UserMetaDataBadgeResponseDTO]
}

public extension UserMetaDataResponseDTO {
    
    func toDomain() -> UserMetaData {
        .init(
            userId: userId, 
            username: username,
            profileURL: profileURL,
            nowBadge: nowBadge.toDomain(),
            badges: badges.map { $0.toDomain() }
        )
    }
    
}

public struct UserMetaDataBadgeResponseDTO: Decodable {
    let badgeId: Int
    let emoji: String
    let badgeName: String
    let badgeExp: Int
    let badgeExplain: String
}

public extension UserMetaDataBadgeResponseDTO {
    
    func toDomain() -> UserMetaDataBadge {
        .init(
            badgeId: badgeId,
            emoji: emoji,
            badgeName: badgeName,
            badgeExp: badgeExp,
            badgeExplain: badgeExplain
        )
    }
    
}
