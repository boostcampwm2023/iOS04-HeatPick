//
//  SignUpTarget.swift
//  NetworkAPIAuth
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import NetworkAPIKit

public struct SignUpTarget: Target {
    
    public var baseURL = URL(string: NetworkHost.base)!
    public var path = "/auth/signup"
    public var method = HTTPMethod.post
    public var header = NetworkHeader.default
    public var task: Task
    
    public init(task: Task) {
        self.task = task
    }
    
}
