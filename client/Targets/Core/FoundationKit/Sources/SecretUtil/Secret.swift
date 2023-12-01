//
//  Secret.swift
//  CoreKit
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum Secret: String {
    
    case naverLoginConsumerKey = "NaverLoginConsumerKey"
    case naverLoginConsumerSecret = "NaverLoginConsumerSecret"
    
    case naverMapClientID = "NaverMapClientID"
    case naverMapSecret = "NaverMapSecret"
    
    case naverSearchLocalClientId = "NaverSearchLocalClientId"
    case naverSearchLocalClientSecret = "NaverSearchLocalClientSecret"
    
    public var value: String {
        guard let value  = Secret.infoDictionary[rawValue] as? String else {
            fatalError("\(rawValue) 설정이 되지 않았습니다")
        }
        return value
    }
    
}

private extension Secret {
    
    static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("info 파일이 존재하지 않습니다.")
        }
        return dict
    }()
    
}
