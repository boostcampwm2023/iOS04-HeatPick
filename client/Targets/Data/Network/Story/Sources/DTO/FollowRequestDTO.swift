//
//  FollowRequestDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct FollowRequestDTO: Encodable {
    
    public let followId: Int
    
    public init(followId: Int) {
        self.followId = followId
    }
    
}
