//
//  CommentReadResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct CommentReadResponseDTO: Decodable {
    
    public let comments: [CommentResponseDTO]
    
    public init(comments: [CommentResponseDTO]) {
        self.comments = comments
    }
    
    public func toDomain() -> [Comment] {
        comments.map { $0.toDomain() }
    }
    
    public struct CommentResponseDTO: Decodable {
        
        public let commentId: Int
        public let userId: Int
        public let userProfileImageURL: String
        public let username: String
        public let createdAt: Date
        public let mentions: [MentionResponseDTO]
        public let content: String
        public let status: Int
        
        public init(commentId: Int, userId: Int, userProfileImageURL: String, username: String, createdAt: Date, mentions: [MentionResponseDTO], content: String, status: Int) {
            self.commentId = commentId
            self.userId = userId
            self.userProfileImageURL = userProfileImageURL
            self.username = username
            self.createdAt = createdAt
            self.mentions = mentions
            self.content = content
            self.status = status
        }
        
        public func toDomain() -> Comment {
            return Comment(id: commentId,
                           author: Author(id: userId, nickname: username, profileImageUrl: userProfileImageURL,
                                          authorStatus: UserStatus.allCases[safe: status] ?? .nonFollowing),
                           date: createdAt,
                           mentionedUsers: mentions.map { $0.toDomain() },
                           content: content)
        }
    }
    
    public struct MentionResponseDTO: Decodable {
        
        public let userId: Int
        public let username: String
        
        public init(userId: Int, username: String) {
            self.userId = userId
            self.username = username
        }
        
        public func toDomain() -> MentionUser {
            return MentionUser(id: userId, name: username)
        }
    }
    
}
