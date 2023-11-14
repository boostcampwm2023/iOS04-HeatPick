//
//  SignInRequestDTO.swift
//  DataNetwork
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SignInRequestDTO: Encodable {
    
    public let OAuthToken: String
    
    public init(OAuthToken: String) {
        self.OAuthToken = OAuthToken
    }
    
}
