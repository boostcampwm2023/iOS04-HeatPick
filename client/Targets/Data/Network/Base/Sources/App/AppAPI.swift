//
//  AppAPI.swift
//  BaseAPI
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import NetworkAPIKit

public enum AppAPI {
    
    case updatePushToken(token: String)
    
}

extension AppAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .updatePushToken: return "/notification/save-fcm-token"
        }
    }
    
    public var method: HTTPMethod {
        return .post
    }
    
    public var header: NetworkHeader {
        return .authorized
    }
    
    public var task: Task {
        switch self {
        case .updatePushToken(let token):
            return .json(["fcmToken": token])
        }
    }
    
}
