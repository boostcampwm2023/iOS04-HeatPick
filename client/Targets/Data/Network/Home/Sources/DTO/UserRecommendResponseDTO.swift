//
//  UserRecommendResponseDTO.swift
//  HomeAPI
//
//  Created by 홍성준 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct UserRecommendResponseDTO: Decodable {
    
    public let users: [UserRecommendUserResponseDTO]
    
}

public struct UserRecommendUserResponseDTO: Decodable {
    
    public let userId: Int
    public let username: String
    public let profileUrl: String?
    
}

public extension UserRecommendResponseDTO {
    
    func toDomain() -> [UserRecommend] {
        return users.map { $0.toDomain() }
    }
}

public extension UserRecommendUserResponseDTO {
    
    func toDomain() -> UserRecommend {
        return .init(
            userId: userId,
            username: username,
            profileUrl: profileUrl
        )
    }
    
}
