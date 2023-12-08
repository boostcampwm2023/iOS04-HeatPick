//
//  AuthContent.swift
//  DomainEntities
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct AuthContent {
    
    public let token: String
    public let username: String
    public var image: Data?
    
    public init(token: String, username: String, image: Data? = nil) {
        self.token = token
        self.username = username
        self.image = image
    }
    
}
