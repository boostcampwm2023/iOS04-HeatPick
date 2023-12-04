//
//  StoryLikeResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct StoryLikeResponseDTO: Decodable {
    
    let likeCount: Int
    
    public init(likeCount: Int) {
        self.likeCount = likeCount
    }
    
    public func toModel() -> Int {
        return likeCount
    }
}
