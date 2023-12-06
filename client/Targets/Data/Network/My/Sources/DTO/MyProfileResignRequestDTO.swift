//
//  MyProfileResignRequestDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MyProfileResignRequestDTO: Encodable {
    
    let reason: String
    
    public init(reason: String) {
        self.reason = reason
    }
    
}
