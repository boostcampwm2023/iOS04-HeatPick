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
    
    public var header: NetworkHeader {
        return .authorized
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
