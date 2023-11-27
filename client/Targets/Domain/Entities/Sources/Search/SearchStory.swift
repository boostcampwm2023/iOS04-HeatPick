//
//  SearchStory.swift
//  DomainEntities
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchStory {
    
    public let id: Int
    public let title: String
    public let content: String
    public let imageURLs: [String]
    public let likeCount: Int
    public let commentCount: Int
    public let createAt: String
    
    public init(
        id: Int,
        title: String,
        content: String,
        imageURLs: [String],
        likeCount: Int,
        commentCount: Int,
        createAt: String
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.imageURLs = imageURLs
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.createAt = createAt
    }
    
}
