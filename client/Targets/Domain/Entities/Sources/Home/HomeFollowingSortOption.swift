//
//  HomeFollowingSortOption.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum HomeFollowingSortOption: Int, CaseIterable {
    
    case recent = 0
    case like
    case comment
    
    public var title: String {
        switch self {
        case .recent: return "최신순"
        case .like: return "좋아요순"
        case .comment: return "댓글순"
        }
    }
    
}
