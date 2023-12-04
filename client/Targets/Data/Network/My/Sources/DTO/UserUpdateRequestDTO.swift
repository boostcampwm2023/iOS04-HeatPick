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
    public let image: [String]
    
    init(userUpdate: UserUpdate) {
        self.username = userUpdate.username
        self.selectedBadgeId = userUpdate.selectedBadgeId
        self.image = userUpdate.image
    }
    
    
}
