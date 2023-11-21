//
//  RecommendResponseDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct RecommendResponseDTO: Decodable {
    
    public struct RecommendStoryResponse: Decodable {
        public let storyId: Int
        public let title: String
        public let content: String
        public let storyImages: [String]
        public let likeCount: Int
        public let createAt: String // "2023-11-21T03:55:45.161Z"
    }
    
    public let recommendStories: [RecommendStoryResponse]
    
}

public extension RecommendResponseDTO {
    
    func toDomain() -> [RecommendStory] {
        return recommendStories
            .map { RecommendStory(
                id: $0.storyId,
                title: $0.title,
                content: $0.content,
                imageURLs: $0.storyImages,
                likeCount: $0.likeCount,
                createAt: $0.createAt
            )}
    }
    
}
