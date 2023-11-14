//
//  Target.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol Target {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: NetworkHeader { get }
    var task: Task { get }
    
}
