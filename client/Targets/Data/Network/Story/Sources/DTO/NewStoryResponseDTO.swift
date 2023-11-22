//
//  NewStoryResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import DomainEntities

public struct NewStoryResponseDTO: Decodable {
    
    let storyId: Int
    
    public init(storyId: Int) {
        self.storyId = storyId
    }
    
    public func toDomain() -> Story {
        return Story(id: storyId, storyContent: nil)
    }
}
