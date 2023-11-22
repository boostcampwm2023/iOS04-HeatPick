//
//  Encodable+Data.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public extension Encodable {
    
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
    
    func dataParameters()-> [String: Data] {
        let mirror = Mirror(reflecting: self)
        var result: [String: Data] = [:]
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        for case let (label?, value) in mirror.children {
            guard let encodableValue = value as? Encodable,
                  let data = try? encoder.encode(encodableValue)
            else { continue }
            
            result[label] = removeQuotes(from: data)
        }
        
        return result
    }
    
    private func removeQuotes(from data: Data) -> Data {
        guard let stringData = String(data: data, encoding: .utf8),
                stringData.hasPrefix("\""),
                stringData.hasSuffix("\"")
        else { return data }
        
        return Data(String(stringData.dropFirst().dropLast()).utf8)
    }
}
