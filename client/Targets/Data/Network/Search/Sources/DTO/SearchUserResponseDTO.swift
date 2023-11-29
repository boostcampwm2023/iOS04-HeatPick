//
//  SearchUserResponseDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SearchUserResponseDTO: Decodable {
    
    public let users: [SearchUserDTO]
    public let isLastPage: Bool
    
}

public extension SearchUserResponseDTO {
    
    func toDomain() -> [SearchUser] {
        users.map { $0.toDomain() }
    }
    
}
