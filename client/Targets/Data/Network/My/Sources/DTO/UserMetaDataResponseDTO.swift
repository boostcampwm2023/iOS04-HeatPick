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
    
    public let profile: UserProfileMetaDataResponseDTO
    
}

public extension UserMetaDataResponseDTO {
    
    func toDomain() -> ProfileUpdateMetaData {
        profile.toDomain()
    }
    
}

public struct UserProfileMetaDataResponseDTO: Decodable {
    public let userId: Int
    public let profileImageURL: String
    public let username: String
    public let nowBadge: UserProfileMetaDataBadgeResponseDTO
    public let badges: [UserProfileMetaDataBadgeResponseDTO]
}

public extension UserProfileMetaDataResponseDTO {
    
    func toDomain() -> ProfileUpdateMetaData {
        .init(
            userId: userId, 
            username: username,
            profileImageURL: profileImageURL,
            nowBadge: nowBadge.toDomain(),
            badges: badges.map { $0.toDomain() }
        )
    }
    
}

public struct UserProfileMetaDataBadgeResponseDTO: Decodable {
    let badgeId: Int
    let badgeName: String
    let badgeExp: Int
    let emoji: String
    // TODO: 옵셔널 제거
    let badgeExplain: String?
}

public extension UserProfileMetaDataBadgeResponseDTO {
    
    func toDomain() -> ProfileUpdateMetaDataBadge {
        .init(
            badgeId: badgeId,
            badgeName: badgeName,
            badgeExp: badgeExp,
            emoji: emoji,
            badgeExplain: badgeExplain
        )
    }
    
}
