//
//  RecommendRequestDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

struct RecommendRequestDTO: Encodable {
    
    let offset: Int
    let limit: Int
    
}
