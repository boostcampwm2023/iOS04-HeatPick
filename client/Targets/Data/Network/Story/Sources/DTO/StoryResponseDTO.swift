//
//  StoryDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct StoryResponseDTO: Decodable {
    
    let storyId: Int
    let createdAt: Date
    let category: String
    let storyImageURL: [String]
    let title: String
    let badgeName: String
    let likeCount: Int
    let commentCount: Int
    let content: String
    let place: PlaceDTO
    
    public init(storyId: Int, createdAt: Date, category: String, storyImageURL: [String], title: String, badgeName: String, likeCount: Int, commentCount: Int, content: String, place: PlaceDTO) {
        self.storyId = storyId
        self.createdAt = createdAt
        self.category = category
        self.storyImageURL = storyImageURL
        self.title = title
        self.badgeName = badgeName
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.content = content
        self.place = place
    }
    
}
