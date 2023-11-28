//
//  CategoryResponseDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct CategoryResponseDTO: Decodable {
    
    public let categoryId: Int
    public let categoryName: String
    
    public init(categoryId: Int, categoryName: String) {
        self.categoryId = categoryId
        self.categoryName = categoryName
    }
    
}
