//
//  MetadataResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct MetadataResponseDTO: Decodable {
    
    public let categories: [CategoryResponseDTO]
    public let badges: [BadgeResponseDTO]
    
    public init(categories: [CategoryResponseDTO], badges: [BadgeResponseDTO]) {
        self.categories = categories
        self.badges = badges
    }
    
    public func toModel() -> ([StoryCategory], [Badge]) {
        return (categories.map { StoryCategory(id: $0.categoryId,
                                               title: $0.categoryName) },
                badges.map { Badge(id: $0.badgeId,
                                   title: $0.badgeName)})
    }
    
}
