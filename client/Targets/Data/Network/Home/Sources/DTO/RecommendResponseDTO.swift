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
        public let likeCount: Int
        public let commentCount: Int
        public let storyImage: String?
        public let user: RecommendUserResponse
    }
    
    public struct RecommendUserResponse: Decodable {
        public let userId: Int
        public let username: String
        public let profileUrl: String?
    }
    
    public let recommededStories: [RecommendStoryResponse]
    public let isLastPage: Bool
    
}

public extension RecommendResponseDTO {
    
    func toDomain() -> HotPlace {
        return .init(
            stories: makeHotPlaceStories(),
            isLastPage: isLastPage
        )
    }
    
    private func makeHotPlaceStories() -> [HotPlaceStory] {
        return recommededStories
            .map { HotPlaceStory(
                id: $0.storyId,
                title: $0.title,
                content: $0.content,
                imageURL: $0.storyImage ?? "",
                userId: $0.user.userId,
                username: $0.user.username,
                userProfileImageURL: $0.user.profileUrl,
                likes: $0.likeCount,
                comments: $0.commentCount
            )}
    }
    
}
