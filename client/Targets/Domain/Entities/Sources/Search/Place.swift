//
//  Place.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Place {
    
    public let storyId: Int
    public let title: String
    public let content: String
    public let imageURL: String
    public let lat: Double
    public let lng: Double
    public let likes: Int
    public let comments: Int
    
    public init(storyId: Int, title: String, content: String, imageURL: String, lat: Double, lng: Double, likes: Int, comments: Int) {
        self.storyId = storyId
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.lat = lat
        self.lng = lng
        self.likes = likes
        self.comments = comments
    }
    
}
