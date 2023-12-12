//
//  RecommendStory.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct RecommendStory {
    
    public let id: Int
    public let title: String
    public let content: String
    public let imageURL: String
    public let likes: Int
    public let comments: Int
    public let lat: Double
    public let lng: Double
    
    public init(
        id: Int, 
        title: String,
        content: String,
        imageURL: String,
        likes: Int,
        comments: Int,
        lat: Double,
        lng: Double
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.likes = likes
        self.comments = comments
        self.lat = lat
        self.lng = lng
    }
    
}

extension RecommendStory: Equatable {
    
    public static func == (lhs: RecommendStory, rhs: RecommendStory) -> Bool {
        lhs.id == rhs.id
    }
    
}
