//
//  NetworkHeader+Authorized.swift
//  BaseAPI
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import FoundationKit
import NetworkAPIKit

public extension NetworkHeader {
    
    static var token: String? {
        guard let data = SecretManager.read(type: .accessToken) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    static var authorized: NetworkHeader {
        guard let token = token else { return .default }
        return .default.authorization(token)
    }
    
}
