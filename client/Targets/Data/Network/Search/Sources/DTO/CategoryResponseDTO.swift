//
//  CategoryResponseDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct CategoryResponseDTO: Decodable {

    public let categories: [CategoryDTO]
    
}

public extension CategoryResponseDTO {
    
    func toDomain() -> [SearchCategory] {
        categories.map { $0.toDomain() }
    }
    
}
