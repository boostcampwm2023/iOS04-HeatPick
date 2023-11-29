//
//  NetworkError.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    
    case invalidURL
    case internalServer
    case failureResponse(Int)
    case emptyRequest
    case emptyResponse
    case unauthorized
    case unknown(String)
    
}
