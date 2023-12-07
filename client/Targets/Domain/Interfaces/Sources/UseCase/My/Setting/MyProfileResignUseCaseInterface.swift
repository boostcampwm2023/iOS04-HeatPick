//
//  MyProfileResignUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol MyProfileResignUseCaseInterface: AnyObject {
    
    func requestResign(reason: String) async -> Result<Void, Error>
    
}
