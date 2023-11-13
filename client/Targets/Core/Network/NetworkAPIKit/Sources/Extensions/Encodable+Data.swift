//
//  Encodable+Data.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

extension Encodable {
    
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601 // 서버와 싱크 필요
        return try encoder.encode(self)
    }
    
    func parameters() -> [String: Any] {
        guard let jsonData = try? jsonData() else { return [:] }
        let parameters = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
        return parameters ?? [:]
    }
    
}
