//
//  LoginUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

public protocol LoginUseCaseInterface {
    
    var naverAcessToken: AnyPublisher<String, Never> { get }
    
    func requestNaverLogin()
    func requestAppleLogin()
}
