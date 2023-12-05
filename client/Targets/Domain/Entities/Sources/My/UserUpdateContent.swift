//
//  UserUpdateContent.swift
//  DomainEntities
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserUpdateContent {
    
    public var username: String
    public var selectedBadgeId: Int
    public var image: Data
    
    public init(username: String, selectedBadgeId: Int, image: Data = Data()) {
        self.username = username
        self.selectedBadgeId = selectedBadgeId
        self.image = image
    }
    
}


public extension UserUpdateContent {
    
    mutating func update(username: String) {
        self.username = username
    }
    
    mutating func update(selectedBadgeId: Int) {
        self.selectedBadgeId = selectedBadgeId
    }
    
    mutating func update(image: Data) {
        self.image = image
    }
    
}
