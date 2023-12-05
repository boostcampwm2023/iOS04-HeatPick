//
//  StoryDeleteRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct StoryDeleteRequestDTO: Encodable {
    
    let storyId: Int
    
    public init(storyId: Int) {
        self.storyId = storyId
    }
    
}
