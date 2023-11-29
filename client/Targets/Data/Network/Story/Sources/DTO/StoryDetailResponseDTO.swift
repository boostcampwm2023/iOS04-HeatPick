//
//  StoryDetailResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import CoreKit
import DomainEntities

public struct StoryDetailResponseDTO: Decodable {
    
    let story: StoryResponseDTO
    let author: AuthorResponseDTO
    
    public init(story: StoryResponseDTO, author: AuthorResponseDTO) {
        self.story = story
        self.author = author
    }
    
    public func toDomain() -> Story {
        return Story(id: story.storyId,
                     storyContent: StoryContent(title: story.title,
                                                content: story.content,
                                                date: story.createdAt,
                                                imageUrls: story.storyImageURL,
                                                category: StoryCategory(id: 0, title: story.category),
                                                place: Location(lat: Float(story.place.latitude),
                                                                lng: Float(story.place.longitude),
                                                                address: story.place.address),
                                                badge: Badge(id: 0, title: story.badgeName)),
                     author: Author(id: author.userId,
                                    nickname: author.username,
                                    profileImageUrl: author.profileImageUrl,
                                    authorStatus: UserStatus.allCases[safe: author.status] ?? .nonFollowing),
                     likesCount: story.likeCount,
                     commentsCount: story.commentCount)
    }
}
