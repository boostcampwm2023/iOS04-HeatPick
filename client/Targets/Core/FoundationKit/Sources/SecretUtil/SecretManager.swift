//
//  SecretManager.swift
//  CoreKit
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum SecretManager {
    
    public enum SecretType: String {
        case accessToken
        case messagingToken
    }
    
    public static func read(type: SecretType) -> Data? {
        let query = NSDictionary(dictionary: [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: type.rawValue,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ])
        var data: AnyObject?
        _ = withUnsafeMutablePointer(to: &data) {
            SecItemCopyMatching(query, UnsafeMutablePointer($0))
        }
        return data as? Data
    }
    
    public static func write(type: SecretType, data: Data) {
        let query = NSDictionary(dictionary: [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: type.rawValue,
            kSecValueData: data
        ])
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }
    
    public static func remove(type: SecretType) {
        guard let data = read(type: type) else { return }
        let query = NSDictionary(dictionary: [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: type.rawValue,
            kSecValueData: data
        ])
        SecItemDelete(query)
    }
    
}
