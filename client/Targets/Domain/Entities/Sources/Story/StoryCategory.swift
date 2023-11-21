//
//  Category.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum StoryCategory: Int, CaseIterable {
    
    case none
    case restaurant
    case cafe
    case travel
    
    public var title: String {
        switch self {
        case .none: return "없음"
        case .restaurant: return "맛집"
        case .cafe: return "카페"
        case .travel: return "여행"
        }
    }
    
}
