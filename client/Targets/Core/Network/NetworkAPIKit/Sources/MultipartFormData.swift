//
//  MultipartFormData.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/12/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct MultipartFormData {
    
    public let data: Encodable
    public let mediaList: [Media]
    
    public init(data: Encodable, mediaList: [Media]) {
        self.data = data
        self.mediaList = mediaList
    }

    public func makeData(boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        let parameters = data.dataParameters()
        for (key, value) in parameters {
            guard let stringValue = String(data: value, encoding: .utf8) else { continue }
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append(stringValue)
            body.append(lineBreak)
        }
        
        for media in mediaList {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(media.key)\"; filename=\"\(media.filename)\"\(lineBreak)")
            body.append("Content-Type: \(media.mimeType + lineBreak + lineBreak)")
            body.append(media.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}

fileprivate extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
}
