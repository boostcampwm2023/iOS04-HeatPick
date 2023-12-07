//
//  AppServiceInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol AppServiceInterface: AnyObject {
    
    func updatePushToken(token: String) async -> Result<Void, Error>
    
}
