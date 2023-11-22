//
//  NewStoryRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct NewStoryRequestDTO: Codable {
    
    let title: String
    let content: String
    let category: String
    let place: PlaceDTO?
    let date: Date
    let badgeId: Int
    
    public init(title: String, content: String, category: String, place: PlaceDTO?, date: Date, badgeId: Int) {
        self.title = title
        self.content = content
        self.category = category
        self.place = place
        self.date = date
        self.badgeId = badgeId
    }
    
    public init(storyContent: StoryContent) {
        
        self.init(title: storyContent.title,
                  content: storyContent.content,
                  category: storyContent.category.title,
                  place: PlaceDTO(latitude: Double(storyContent.place.lat), longitude: Double(storyContent.place.lng)),
                  date: storyContent.date,
                  badgeId: storyContent.badgeId)
    }
}
