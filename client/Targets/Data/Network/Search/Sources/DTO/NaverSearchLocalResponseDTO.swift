//
//  NaverSearchLocalResponseDTO.swift.swift
//  SearchAPI
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct NaverSearchLocalResponseDTO: Decodable {
    
    public let total: Int
    public let start: Int
    public let display: Int
    public let items: [NaverSearchLocalDTO]
    
}

public extension NaverSearchLocalResponseDTO {
    
    func toDomain() -> [SearchLocal] {
        return items.compactMap { $0.toDomain() }
    }
    
}
