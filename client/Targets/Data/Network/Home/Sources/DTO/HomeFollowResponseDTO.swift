//
//  HomeFollowResponseDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

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
