//
//  RecommendPlace.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct RecommendPlace {
    
    public let title: String
    public let stories: [RecommendStory]
    
    public init(title: String, stories: [RecommendStory]) {
        self.title = title
        self.stories = stories
    }
    
}
