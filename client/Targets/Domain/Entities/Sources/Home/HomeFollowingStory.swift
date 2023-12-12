//
//  HomeFollowingStory.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct HomeFollowingStory {
    
    public let storyId: Int
    public let title: String
    public let content: String
    public let imageURL: String
    public let userId: Int
    public let username: String
    public let userProfileImageURL: String?
    public let likes: Int 
    public let comments: Int
    
    public init(
        storyId: Int,
        title: String,
        content: String,
        imageURL: String,
        userId: Int,
        username: String,
        userProfileImageURL: String?,
        likes: Int,
        comments: Int
    ) {
        self.storyId = storyId
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.userId = userId
        self.username = username
        self.userProfileImageURL = userProfileImageURL
        self.likes = likes
        self.comments = comments
    }
    
}

extension HomeFollowingStory: Equatable {
    
    public static func == (lhs: HomeFollowingStory, rhs: HomeFollowingStory) -> Bool {
        return lhs.storyId == rhs.storyId
    }
    
}
