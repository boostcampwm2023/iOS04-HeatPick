//
//  SearchRecommendResponseDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchRecommendResponseDTO: Decodable {
    
    public let recommendTexts: [String]
    
}

public extension SearchRecommendResponseDTO {
    
    func toDmain() -> [String] {
        recommendTexts
    }
    
}
