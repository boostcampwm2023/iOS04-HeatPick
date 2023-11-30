//
//  SearchLocal.swift
//  DomainEntities
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchLocal {
    
    public let title: String
    public let roadAddress: String
    
    public init(title: String, roadAddress: String) {
        self.title = title
        self.roadAddress = roadAddress
    }
    
}
