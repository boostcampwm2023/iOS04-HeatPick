//
//  PlaceStory.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct PlaceStory {
    
    public let id: Int
    public let title: String
    public let content: String
    public let imageURLs: [String]
    public let likeCount: Int
    public let commentCount: Int
    
    public init(id: Int, title: String, content: String, imageURLs: [String], likeCount: Int, commentCount: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.imageURLs = imageURLs
        self.likeCount = likeCount
        self.commentCount = commentCount
    }
    
}
