//
//  SearchStory.swift
//  DomainEntities
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchStory {
    
    public let storyId: Int
    public let title: String
    public let content: String
    public let likeCount: Int
    public let commentCount: Int
    public let storyImage: String
    public let categoryId: Int

    public init(storyId: Int, title: String, content: String, likeCount: Int, commentCount: Int, storyImage: String, categoryId: Int) {
        self.storyId = storyId
        self.title = title
        self.content = content
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.storyImage = storyImage
        self.categoryId = categoryId
    }
    
}
