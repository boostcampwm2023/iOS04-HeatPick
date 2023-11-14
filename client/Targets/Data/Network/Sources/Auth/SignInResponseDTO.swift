//
//  SignInResponseDTO.swift
//  DataNetwork
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct SignInResponseDTO: Decodable {
    
    public let token: String
    
}

public extension SignInResponseDTO {
    
    func toDomain() -> AuthToken {
        return AuthToken(token: token)
    }
    
}
