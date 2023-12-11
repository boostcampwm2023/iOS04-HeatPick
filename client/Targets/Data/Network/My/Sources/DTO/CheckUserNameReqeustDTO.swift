//
//  CheckUserNameReqeustDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct CheckUserNameReqeustDTO: Encodable {
    
    public let username: String
    
    public init(username: String) {
        self.username = username
    }
    
}

