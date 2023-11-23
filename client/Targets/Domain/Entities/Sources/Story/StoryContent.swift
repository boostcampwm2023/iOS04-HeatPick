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
    public let imageUrls: [String]
    public let category: String
    public let place: Location
    public let badgeId: Int
    public let badgeName: String
    
    public init(title: String, content: String, date: Date, images: [Data] = [], imageUrls: [String] = [], category: String, place: Location, badgeId: Int = 0, badgeName: String = "") {
        self.title = title
        self.content = content
        self.date = date
        self.images = images
        self.imageUrls = imageUrls
        self.category = category
        self.place = place
        self.badgeId = badgeId
        self.badgeName = badgeName
    }
    
}
