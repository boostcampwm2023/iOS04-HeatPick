//
//  MyProfileResponseDTO.swift
//  MyAPI
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainEntities

public struct MyProfileResponseDTO: Decodable {
    
    public let profile: MyProfileProfileResponseDTO
    
}

public struct MyProfileProfileResponseDTO: Decodable {
    
    public let userId: Int
    public let username: String
    public let profileURL: String?
    public let isFollow: Int
    public let followerCount: Int
    public let storyCount: Int
    public let experience: Int
    public let maxExperience: Int
    public let temperature: Int
    public let temperatureFeeling: String
    public let mainBadge: MyProfileBadgeResponseDTO
    public let badgeExplain: String
    public let storyList: [MyProfileStoryResponseDTO]
    
}

public struct MyProfileBadgeResponseDTO: Decodable {
    let badgeId: Int
    let badgeName: String
    let badgeExp: Int
    let emoji: String
}

public struct MyProfileStoryResponseDTO: Decodable {
    public let storyId: Int
    public let title: String
    public let content: String
    public let thumbnailImageURL: String?
    public let likeCount: Int
    public let commentCount: Int
}

public extension MyProfileResponseDTO {
    
    func toDomain() -> MyPage {
        return .init(
            userId: profile.userId,
            userName: profile.username,
            profileImageURL: profile.profileURL,
            isFollow: profile.isFollow,
            temperature: profile.temperature,
            temperatureFeeling: profile.temperatureFeeling,
            followerCount: profile.followerCount,
            storyCount: profile.storyCount,
            experience: profile.experience,
            maxExperience: profile.maxExperience,
            mainBadge: profile.mainBadge.toDomain(description: profile.badgeExplain),
            stories: profile.storyList.map { $0.toDomain() }
        )
    }
    
}

public extension MyProfileBadgeResponseDTO {
    
    func toDomain(description: String) -> MyPageBadge {
        return .init(
            id: badgeId,
            name: badgeName,
            experience: badgeExp,
            emoji: emoji,
            description: description
        )
    }
    
}

public extension MyProfileStoryResponseDTO {
    
    func toDomain() -> MyPageStory {
        return .init(
            storyId: storyId,
            title: title, 
            content: content.withLineBreak,
            thumbnailImageURL: thumbnailImageURL,
            likeCount: likeCount,
            commentCount: commentCount
        )
    }
}
