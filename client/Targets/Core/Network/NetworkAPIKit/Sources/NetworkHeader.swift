//
//  NetworkHeader.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public class NetworkHeader {
    
    public var headers: [String: String] = [:]
    
    @discardableResult
    public func contentType(_ value: String) -> Self {
        headers["Content-Type"] = value
        return self
    }
    
    @discardableResult
    public func authToken(_ value: String) -> Self {
        headers["Auth-Token"] = value
        return self
    }
    
    @discardableResult
    public func withMultipartFormData(boundary: String) -> Self {
        contentType("multipart/form-data; boundary=\(boundary)")
        return self
    }
    
    @discardableResult
    public func withJSON() -> Self {
        contentType("application/json")
        return self
    }
    
}
