//
//  NetworkHost.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public enum NetworkHost {
    
    public static var base: String {
        guard let url = infoDictionary["BaseURL"] as? String else {
            fatalError("URL 설정이 되지 않았습니다")
        }
        return url
    }
    
}

private extension NetworkHost {
    
    static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("info 파일이 존재하지 않습니다.")
        }
        return dict
    }()
    
}
