//
//  MultipartFormData.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/12/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MultipartFormData {
    
    public let data: Data
    public let name: String
    public let fileName: String
    public let mimeType: String
    
    public init(data: Data, name: String, fileName: String, mimeType: String) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    public func makeData(boundary: String) -> Data {
        var body = Data()
        body.append("--\(boundary)\r\n".utf8)
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".utf8)
        body.append("Content-Type: \(mimeType)\r\n\r\n".utf8)
        body.append(data)
        body.append("\r\n".utf8)
        body.append("--\(boundary)--\r\n".utf8)
        return body
    }
    
}
