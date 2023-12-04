//
//  UserUpdate.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserUpdate {
    
    public let username: String
    public let selectedBadgeId: Int
    public let image: [String]
    
    public init(username: String, selectedBadgeId: Int, image: [String]) {
        self.username = username
        self.selectedBadgeId = selectedBadgeId
        self.image = image
    }
    
}
