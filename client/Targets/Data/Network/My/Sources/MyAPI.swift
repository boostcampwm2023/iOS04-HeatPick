//
//  MyAPI.swift
//  MyAPI
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit

public enum MyAPI {
    case myProfile
    case profile(id: Int)
}

extension MyAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .myProfile: return "/user/myProfile"
        case .profile: return "/user/profile"
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    // TODO: - 인증 헤더로 변경하기
    // 서버에서 수정 후에 반영하기로 하였음
    // 연관 링크: https://boostcampwm-8-me.slack.com/archives/C060U825MJM/p1700715202562749?thread_ts=1700707590.757289&cid=C060U825MJM
    public var header: NetworkHeader {
        return .default
    }
    
    public var task: Task {
        switch self {
        case .myProfile:
            return .plain
            
        case .profile(let id):
            return .url(parameters: ["userId": id])
        }
    }
    
}
