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
    public let storyContent: StoryContent?
    
    public init(id: Int, storyContent: StoryContent?) {
        self.id = id
        self.storyContent = storyContent
    }
    
}
