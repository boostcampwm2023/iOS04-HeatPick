//
//  AccessTokenResponseDTO.swift
//  GithubAPI
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct AccessTokenResponseDTO: Decodable {
    
    public let access_token: String
    
    public init(access_token: String) {
        self.access_token = access_token
    }
    
    public func toDomain() -> String {
        return access_token
    }
}
