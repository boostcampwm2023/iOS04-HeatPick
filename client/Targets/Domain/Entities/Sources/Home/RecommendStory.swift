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
    public let imageURLs: [String]
    public let likeCount: Int
    public let createAt: String
    
    public init(id: Int, title: String, content: String, imageURLs: [String], likeCount: Int, createAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.imageURLs = imageURLs
        self.likeCount = likeCount
        self.createAt = createAt
    }
    
}
