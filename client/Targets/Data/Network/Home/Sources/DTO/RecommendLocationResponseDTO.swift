//
//  RecommendLocationResponseDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct RecommendLocationResponseDTO: Decodable {
    
    public struct RecommendStoryResponse: Decodable {
        public let storyId: Int
        public let title: String
        public let content: String
        public let storyImage: String
    }
    
    public let recommededStories: [RecommendStoryResponse]
    public let isLastPage: Bool
    
}

public extension RecommendLocationResponseDTO {
    
    func toDomain() -> RecommendStoryWithPaging {
        return .init(
            stories: makeRecommendStories(),
            isLastPage: isLastPage
        )
    }
    
    func makeRecommendStories() -> [RecommendStory] {
        return recommededStories
            .map { RecommendStory(
                id: $0.storyId,
                title: $0.title,
                content: $0.content,
                imageURL: $0.storyImage
            )}
    }
    
}
