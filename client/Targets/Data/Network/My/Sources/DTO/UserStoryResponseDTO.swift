//
//  UserStoryResponseDTO.swift
//  MyAPI
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct UserStoryResponseDTO: Decodable {
    
    public let storyId: Int
    public let thumbnailImageURL: String?
    public let title: String
    public let content: String
    public let likeState: Int
    public let likeCount: Int
    public let commentCount: Int
    
    public init(storyId: Int, thumbnailImageURL: String?, title: String, content: String, likeState: Int, likeCount: Int, commentCount: Int) {
        self.storyId = storyId
        self.thumbnailImageURL = thumbnailImageURL
        self.title = title
        self.content = content
        self.likeState = likeState
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
    
}

public extension UserStoryResponseDTO {
    
    func toDomain() -> MyPageStory {
        return .init(
            storyId: storyId,
            title: title,
            content: content,
            thumbnailImageURL: thumbnailImageURL,
            likeCount: likeCount,
            commentCount: commentCount
        )
    }
    
}
