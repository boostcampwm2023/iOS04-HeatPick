//
//  Task.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum Task {
    
    case plain
    case data(Data)
    case json(Encodable)
    case url(parameters: [String: Any])
    case path(String)
    case multipart(MultipartFormData)
    
}
