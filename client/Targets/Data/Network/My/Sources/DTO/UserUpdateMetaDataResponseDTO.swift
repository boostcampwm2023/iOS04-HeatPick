//
//  UserUpdateMetaDataResponseDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainEntities

public struct UserUpdateMetaDataResponseDTO: Decodable {
    public let userId: Int
    public let username: String
    public let profileURL: String?
    public let nowBadge: UserUpdateMetaDataBadgeResponseDTO
    public let badges: [UserUpdateMetaDataBadgeResponseDTO]
}

public struct UserUpdateMetaDataBadgeResponseDTO: Decodable {
    let badgeId: Int
    let badgeName: String
    let badgeExp: Int
    let emoji: String
    let badgeExplain: String
}
