//
//  CommentContent.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct CommentContent {
    
    public let storyId: Int
    public let content: String
    public let mentions: [Int]
    
    public init(storyId: Int, content: String, mentions: [Int]) {
        self.storyId = storyId
        self.content = content
        self.mentions = mentions
    }
    
}
