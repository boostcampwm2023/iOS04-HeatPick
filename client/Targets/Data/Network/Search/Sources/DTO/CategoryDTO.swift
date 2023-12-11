//
//  CategoryDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct CategoryDTO: Decodable {
    
    public let categoryId: Int
    public let categoryName: String
    public let categoryContent: String
    
    public init(
        categoryId: Int,
        categoryName: String,
        categoryContent: String
    ) {
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.categoryContent = categoryContent
    }
    
}

public extension CategoryDTO {
    
    func toDomain() -> SearchCategory {
        .init(
            categoryId: categoryId,
            categoryName: categoryName,
            categoryContent: categoryContent
        )
    }
    
}
