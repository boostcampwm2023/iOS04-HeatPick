//
//  PlaceResponseDTO.swift
//  SearchAPI
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct PlaceResponseDTO: Decodable {
    
    public struct PlaceContentResponseDTO: Decodable {
        public let placeId: Int
        public let title: String
        public let address: String
        public let latitude: Double
        public let longitude: Double
        public let story: PlaceStoryResponseDTO
    }
    
    public struct PlaceStoryResponseDTO: Decodable {
        public let storyId: Int
        public let title: String
        public let content: String
        public let storyImages: [String]
        public let likeCount: Int
        public let commentCount: Int
    }
    
    public let places: [PlaceContentResponseDTO]
    
}

public extension PlaceResponseDTO.PlaceContentResponseDTO {
    
    func toDomain() -> Place {
        return .init(
            placeID: placeId,
            title: title,
            address: address,
            lat: latitude,
            lng: longitude,
            storyID: story.storyId,
            storyTitle: story.title,
            storyContent: story.content,
            storyImageURLs: story.storyImages,
            likeCount: story.likeCount,
            commentCount: story.commentCount
        )
    }
}

public extension PlaceResponseDTO {
    
    func toDomain() -> [Place] {
        return places.map { $0.toDomain() }
    }
    
}
