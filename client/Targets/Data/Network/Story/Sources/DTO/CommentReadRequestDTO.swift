//
//  CommentReadRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct CommentReadRequestDTO: Encodable {
    
    public let storyId: Int
    
    public init(storyId: Int) {
        self.storyId = storyId
    }
    
}
