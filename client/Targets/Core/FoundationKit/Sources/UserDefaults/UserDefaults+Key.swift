//
//  UserDefaults+Key.swift
//  FoundationKit
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    enum Key: String {
        
        case remoteNotification
        case initialSignInDate
        case recentSearch
        case firstStoryGuideDidShow // 지도 화면 스토리 가이드 보여짐 여부
        
    }
    
}
