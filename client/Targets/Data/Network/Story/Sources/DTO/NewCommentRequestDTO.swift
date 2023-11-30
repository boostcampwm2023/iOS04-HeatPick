//
//  NewCommentRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct NewCommentRequestDTO: Encodable {
    
    let storyId: Int
    let content: String
    let mentions: [Int]
    
    public init(storyId: Int, content: String, mentions: [Int]) {
        self.storyId = storyId
        self.content = content
        self.mentions = mentions
    }
    
    public init(content: CommentContent) {
        self.init(storyId: content.storyId, content: content.content, mentions: content.mentions)
    }
}
