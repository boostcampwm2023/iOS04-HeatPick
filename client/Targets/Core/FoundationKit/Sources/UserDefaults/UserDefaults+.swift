//
//  UserDefaults+.swift
//  FoundationKit
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    func setValue(_ value: Any?, forKey key: UserDefaults.Key) {
        setValue(value, forKey: key.rawValue)
    }
    
    func integer(forKey key: UserDefaults.Key) -> Int {
        integer(forKey: key.rawValue)
    }
    
    func bool(forKey key: UserDefaults.Key) -> Bool {
        bool(forKey: key.rawValue)
    }
    
    func string(forKey key: UserDefaults.Key) -> String? {
        string(forKey: key.rawValue)
    }
    
    func object(forKey key: UserDefaults.Key) -> Any? {
        object(forKey: key.rawValue)
    }
    
    func removeObject(forKey key: UserDefaults.Key) {
        removeObject(forKey: key.rawValue)
    }
    
}
