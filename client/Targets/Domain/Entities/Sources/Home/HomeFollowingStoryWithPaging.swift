//
//  HomeFollowingStoryWithPaging.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct HomeFollowingStoryWithPaging {
    
    public let stories: [HomeFollowingStory]
    public let isLastPage: Bool
    
    public init(stories: [HomeFollowingStory], isLastPage: Bool) {
        self.stories = stories
        self.isLastPage = isLastPage
    }
    
}
