//
//  Place.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Place {
    
    public let placeID: Int
    public let title: String
    public let address: String
    public let lat: Double
    public let lng: Double
    public let storyID: Int
    public let storyTitle: String
    public let storyContent: String
    public let storyImageURLs: [String]
    public let likeCount: Int
    public let commentCount: Int
    
    public init(placeID: Int, title: String, address: String, lat: Double, lng: Double, storyID: Int, storyTitle: String, storyContent: String, storyImageURLs: [String], likeCount: Int, commentCount: Int) {
        self.placeID = placeID
        self.title = title
        self.address = address
        self.lat = lat
        self.lng = lng
        self.storyID = storyID
        self.storyTitle = storyTitle
        self.storyContent = storyContent
        self.storyImageURLs = storyImageURLs
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
    
}
