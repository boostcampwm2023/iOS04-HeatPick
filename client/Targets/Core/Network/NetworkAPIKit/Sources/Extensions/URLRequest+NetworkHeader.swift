//
//  URLRequest+NetworkHeader.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/12/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func setHeader(_ header: NetworkHeader) {
        header.headers.forEach {
            setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
    
}
