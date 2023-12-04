//
//  UserUpdateRequestDTO.swift
//  MyAPI
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct UserUpdateRequestDTO: Encodable {
    
    let username: String
    let selectedBadgeId: Int
    let image: [String]
    
}
