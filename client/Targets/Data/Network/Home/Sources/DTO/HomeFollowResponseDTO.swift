//
//  HomeFollowResponseDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainEntities

public struct HomeFollowResponseDTO: Decodable {
    
    public struct HomeFollowStoryResponse: Decodable {
        public let storyId: Int
        public let title: String
        public let content: String
        public let likeCount: Int
        public let commentCount: Int
        public let storyImage: String?
        public let user: HomeFollowUserResponse
    }
    
    public struct HomeFollowUserResponse: Decodable {
        public let userId: Int
        public let username: String
        public let profileUrl: String?
    }
    
    public let recommededStories: [HomeFollowStoryResponse]
    public let isLastPage: Bool
    
}

public extension HomeFollowResponseDTO {
    
    func toDomain() -> HomeFollowingStoryWithPaging {
        return .init(
            stories: makeFollowingStories(),
            isLastPage: isLastPage
        )
    }
    
    func makeFollowingStories() -> [HomeFollowingStory] {
        return recommededStories
            .map { .init(
                storyId: $0.storyId,
                title: $0.title,
                content: $0.content.withLineBreak,
                imageURL: $0.storyImage ?? "",
                userId: $0.user.userId,
                username: $0.user.username,
                userProfileImageURL: $0.user.profileUrl,
                likes: $0.likeCount,
                comments: $0.commentCount
            )}
    }
    
}
