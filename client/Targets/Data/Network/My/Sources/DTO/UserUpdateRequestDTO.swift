//
//  UserUpdateRequestDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct UserUpdateRequestDTO: Encodable {
    
    public let username: String
    public let selectedBadgeId: Int
    
    init(content: UserUpdateContent) {
        self.username = content.username
        self.selectedBadgeId = content.selectedBadgeId
    }
    
}
