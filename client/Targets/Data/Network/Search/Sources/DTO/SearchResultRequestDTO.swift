//
//  SearchResultRequestDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchResultRequestDTO: Encodable {

    let searchText: String?
    let categoryId: Int?
    
}
