//
//  NaverSearchLocalRequestDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct NaverSearchLocalRequestDTO: Encodable {
    
    let query: String
    let display: Int = 5
    
}


public struct NaverSearchLocalDTO: Decodable {
    
    public let title: String
    public let link: String
    public let category: String
    public let description: String
    public let address: String
    public let roadAddress: String
    public let mapx: String
    public let mapy: String
     
}

public extension NaverSearchLocalDTO {
    
    func toDomain() -> SearchLocal {
        .init(title: title, roadAddress: roadAddress)
    }
    
}
