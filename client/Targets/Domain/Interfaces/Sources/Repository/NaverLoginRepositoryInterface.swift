//
//  NaverLoginRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

public protocol NaverLoginRepositoryInterface: AnyObject {
    
    var accessToken: AnyPublisher<String, Never> { get }
    
    func setup()
    func requestLogin()
}
