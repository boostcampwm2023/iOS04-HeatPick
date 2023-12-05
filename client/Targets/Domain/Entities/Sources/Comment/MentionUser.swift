//
//  MentionUser.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MentionUser {
    
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}
