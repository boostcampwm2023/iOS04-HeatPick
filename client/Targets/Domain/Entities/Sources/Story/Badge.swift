//
//  Badge.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum Badge: Int, CaseIterable {
    case none
    case jogger
    case cyclist
    case foodie
    case caffeineAddicted
    
    public var title: String {
        switch self {
        case .none: return "없음"
        case .jogger: return "🚶 뚜벅이"
        case .cyclist: return "🚴 사이클리스트"
        case .foodie: return "🥘 맛집 탐방가"
        case .caffeineAddicted: return "☕️ 카페인 중독자"
        }
    }
    
}
