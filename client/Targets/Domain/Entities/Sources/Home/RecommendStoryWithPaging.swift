//
//  RecommendStoryWithPaging.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct RecommendStoryWithPaging {
    
    public let stories: [RecommendStory]
    public let isLastPage: Bool
    
    public init(stories: [RecommendStory], isLastPage: Bool) {
        self.stories = stories
        self.isLastPage = isLastPage
    }
    
}
