//
//  SearchResultResponseDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SearchResultResponseDTO: Decodable {
    
    public let stories: [SearchStroyDTO]
    public let users: [SearchUserDTO]
    
}

public extension SearchResultResponseDTO {
    
    func toDomain() -> SearchResult {
        SearchResult(
            stories: stories.map { $0.toDomain() },
            users: users.map { $0.toDomain() }
        )
    }
    
}
