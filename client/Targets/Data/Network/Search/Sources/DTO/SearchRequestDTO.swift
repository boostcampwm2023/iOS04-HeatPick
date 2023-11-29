//
//  SearchRequestDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchRequestDTO: Encodable {

    let searchText: String
    let offset: Int = 0
    let limit: Int = 25
    
}
