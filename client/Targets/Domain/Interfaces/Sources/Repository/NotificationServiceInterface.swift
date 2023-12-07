//
//  NotificationServiceInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol NotificationServiceInterface: AnyObject {
    
    func requestAuthorization() async throws -> Bool
    func registerNotification()
    func registerNotification() async
    
}
