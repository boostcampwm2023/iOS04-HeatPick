//
//  SignUpRequestDTO.swift
//  DataNetwork
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SignUpRequestDTO: Encodable {
    
    public let OAuthToken: String
    public let username: String
    
    public init(OAuthToken: String, username: String) {
        self.OAuthToken = OAuthToken
        self.username = username
    }
    
}
