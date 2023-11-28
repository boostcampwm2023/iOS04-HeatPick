//
//  SearchUserDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SearchUserDTO: Decodable {
    
    public let userId: Int
    public let username: String
    public let profileUrl: String
    
}

public extension SearchUserDTO {
    
    func toDomain() -> SearchUser {
        SearchUser(
            userId: self.userId,
            username: self.username,
            profileUrl: self.profileUrl
        )
    }

}
