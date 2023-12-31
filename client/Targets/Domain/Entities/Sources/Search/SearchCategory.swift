//
//  SearchCategory.swift
//  DomainEntities
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchCategory {
    
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
