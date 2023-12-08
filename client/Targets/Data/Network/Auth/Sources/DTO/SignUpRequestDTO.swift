//
//  SignUpRequestDTO.swift
//  DataNetwork
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SignUpRequestDTO: Encodable {
    
    public let OAuthToken: String
    public let username: String
    
    public init(content: AuthContent) {
        self.OAuthToken = content.token
        self.username = content.username
    }
    
}
