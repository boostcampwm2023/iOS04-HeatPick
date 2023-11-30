//
//  MyPageStory.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MyPageStory {
    
    public let storyId: Int
    public let title: String
    public let content: String
    public let thumbnailImageURL: String?
    public let likeCount: Int
    public let commentCount: Int
    
    public init(storyId: Int, title: String, content: String, thumbnailImageURL: String?, likeCount: Int, commentCount: Int) {
        self.storyId = storyId
        self.title = title
        self.content = content
        self.thumbnailImageURL = thumbnailImageURL
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
    
}
