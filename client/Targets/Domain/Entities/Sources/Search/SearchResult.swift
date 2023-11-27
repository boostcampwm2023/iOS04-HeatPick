//
//  SearchResult.swift
//  DomainEntities
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchResult {
    
    public let stories: [SearchStory]
    public let users: [SearchUser]
    
    public init(stories: [SearchStory], users: [SearchUser]) {
        self.stories = stories
        self.users = users
    }
    
}
