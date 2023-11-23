//
//  StoryDetailRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import DomainEntities

public struct StoryDetailRequestDTO: Encodable {
    
    let storyId: Int
    
    public init(story: Story) {
        self.storyId = story.id
    }
    
}
