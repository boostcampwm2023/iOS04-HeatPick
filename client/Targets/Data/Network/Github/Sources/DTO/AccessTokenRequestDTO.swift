//
//  AccessTokenRequestDTO.swift
//  GithubAPI
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct AccessTokenRequestDTO: Encodable {
    
    let client_id: String
    let client_secret: String
    let code: String
    
    public init(client_id: String, client_secret: String, code: String) {
        self.client_id = client_id
        self.client_secret = client_secret
        self.code = code
    }
    
}
