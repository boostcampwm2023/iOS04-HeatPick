//
//  BadgeResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct BadgeResponseDTO: Decodable {
    
    public let badgeId: Int
    public let badgeName: String
    
    public init(badgeId: Int, badgeName: String) {
        self.badgeId = badgeId
        self.badgeName = badgeName
    }
    
}
