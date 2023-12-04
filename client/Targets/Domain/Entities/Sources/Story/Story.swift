//
//  Story.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Story {
    
    public let id: Int
    public let content: StoryContent?
    public let author: Author?
    public let likeStatus: Bool
    public let likesCount: Int
    public let commentsCount: Int
    
    public init(id: Int, storyContent: StoryContent? = nil, author: Author? = nil, likeStatus: Bool = false, likesCount: Int = 0, commentsCount: Int = 0) {
        self.id = id
        self.content = storyContent
        self.author = author
        self.likeStatus = likeStatus
        self.likesCount = likesCount
        self.commentsCount = commentsCount
    }
    
}
