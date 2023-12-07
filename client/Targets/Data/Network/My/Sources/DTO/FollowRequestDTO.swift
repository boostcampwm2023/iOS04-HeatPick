//
//  FollowRequestDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct FollowRequestDTO: Encodable {
    
    public let followId: Int
    
    public init(followId: Int) {
        self.followId = followId
    }
    
}
