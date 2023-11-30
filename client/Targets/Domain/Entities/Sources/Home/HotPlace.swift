//
//  HotPlace.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct HotPlace {
    
    public let stories: [HotPlaceStory]
    public let isLastPage: Bool
    
    public init(stories: [HotPlaceStory], isLastPage: Bool) {
        self.stories = stories
        self.isLastPage = isLastPage
    }
    
}
