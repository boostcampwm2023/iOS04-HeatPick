//
//  StoryLikeRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct StoryLikeRequestDTO: Encodable {
    
    let storyId: Int
    
    public init(storyId: Int) {
        self.storyId = storyId
    }
    
}
