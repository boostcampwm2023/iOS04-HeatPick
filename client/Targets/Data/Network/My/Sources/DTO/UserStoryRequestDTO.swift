//
//  UserStoryRequestDTO.swift
//  MyAPI
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

struct UserStoryRequestDTO: Encodable {
    
    let userId: Int
    let offset: Int
    let limit: Int
    
}
