//
//  HotPlace.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct HotPlace {
    
    public let id: Int
    public let title: String
    public let imageURLs: [String]
    public let userId: Int
    public let username: String
    public let userProfileImageURL: String?
    
    public init(
        id: Int,
        title: String,
        imageURLs: [String],
        userId: Int,
        username: String,
        userProfileImageURL: String?
        
    ) {
        self.id = id
        self.title = title
        self.imageURLs = imageURLs
        self.userId = userId
        self.username = username
        self.userProfileImageURL = userProfileImageURL
    }
    
}