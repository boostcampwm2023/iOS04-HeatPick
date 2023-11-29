//
//  SearchStroyResponseDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SearchStroyResponseDTO: Decodable {
    
    public let stories: [SearchStroyDTO]
    public let isLastPage: Bool
    
}

public extension SearchStroyResponseDTO {
    
    func toDomain() -> [SearchStory] {
        stories.map { $0.toDomain() }
    }

}

