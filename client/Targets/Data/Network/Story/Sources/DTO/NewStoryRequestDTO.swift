//
//  NewStoryRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct NewStoryRequestDTO: Encodable {
    
    let title: String
    let content: String
    let categoryId: Int
    let place: PlaceDTO
    let date: Date
    let badgeId: Int
    
    public init(title: String, content: String, categoryId: Int, place: PlaceDTO, date: Date, badgeId: Int) {
        self.title = title
        self.content = content
        self.categoryId = categoryId
        self.place = place
        self.date = date
        self.badgeId = badgeId
    }
    
    public init(storyContent: StoryContent) {
        
        self.init(title: storyContent.title,
                  content: storyContent.content,
                  categoryId: storyContent.category.id,
                  place: PlaceDTO(latitude: storyContent.place.lat, longitude: storyContent.place.lng),
                  date: storyContent.date,
                  badgeId: storyContent.badge.id)
    }
}
