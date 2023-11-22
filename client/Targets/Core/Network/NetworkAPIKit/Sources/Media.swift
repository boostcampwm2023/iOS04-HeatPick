//
//  Media.swift
//  NetworkAPIKit
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Media {
    
    public enum MediaType {
        case jpeg
        case png
        
        var mimeType: String {
            switch self {
            case .jpeg: return "jpeg"
            case .png: return "png"
            }
        }
    }
    
    let type: MediaType
    let key: String
    let data: Data
    let file: String

    var mimeType: String {
        "\(key)/\(type.mimeType)"
    }
    var filename: String {
        "\(file).\(type.mimeType)"
    }
    
    public init(data: Data, type: MediaType, key: String) {
        self.type = type
        self.key = key
        self.data = data
        self.file = String(arc4random())
    }
    
}
