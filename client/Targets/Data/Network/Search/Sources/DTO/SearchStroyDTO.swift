//
//  SearchStroyDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SearchStroyDTO: Decodable {
    
    public let storyId: Int
    public let title: String
    public let content: String
    public let likeCount: Int
    public let commentCount: Int
    public let storyImage: String
    public let categoryId: Int
    
}


public extension SearchStroyDTO {
    
    func toDomain() -> SearchStory {
        SearchStory(
            storyId: self.storyId,
            title: self.title,
            content: self.content,
            likeCount: self.likeCount,
            commentCount: self.commentCount,
            storyImage: self.storyImage,
            categoryId: self.categoryId
        )
    }
    
}
