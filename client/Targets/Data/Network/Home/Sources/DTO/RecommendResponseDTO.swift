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
        public let storyImages: [String]
        public let user: RecommendUserResponse
    }
    
    public struct RecommendUserResponse: Decodable {
        public let userId: Int
        public let username: String
        public let profileImage: String?
    }
    
    public let recommededStories: [RecommendStoryResponse]
    
}

public extension RecommendResponseDTO {
    
    func toDomain() -> [HotPlace] {
        return recommededStories
            .map { HotPlace(
                id: $0.storyId,
                title: $0.title,
                imageURLs: $0.storyImages,
                userId: $0.user.userId,
                username: $0.user.username,
                userProfileImageURL: $0.user.profileImage
            )}
    }
    
}
