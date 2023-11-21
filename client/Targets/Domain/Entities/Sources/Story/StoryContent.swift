//
//  StoryContent.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct StoryContent {
    
    public let title: String
    public let content: String
    public let date: Date
    public let images: [Data]
    public let category: StoryCategory
    public let place: Location
    public let badge: Badge
    
    public init(title: String, content: String, date: Date, images: [Data], category: StoryCategory, place: Location, badge: Badge) {
        self.title = title
        self.content = content
        self.date = date
        self.images = images
        self.category = category
        self.place = place
        self.badge = badge
    }
    
}
