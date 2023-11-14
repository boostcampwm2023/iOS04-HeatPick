//
//  SignUpResponseDTO.swift
//  DataNetwork
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SignUpResponseDTO: Decodable {
    
    public let token: String
    
}

public extension SignUpResponseDTO {
    
    func toDomain() -> AuthToken {
        return AuthToken(token: token)
    }
    
}
