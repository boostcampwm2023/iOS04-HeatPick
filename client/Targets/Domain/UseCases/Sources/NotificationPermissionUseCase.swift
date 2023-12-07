//
//  NotificationPermissionUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainInterfaces

public final class NotificationPermissionUseCase: NotificationPermissionUseCaseInterface {
    
    private let service: NotificationServiceInterface
    
    public init(service: NotificationServiceInterface) {
        self.service = service
    }
    
    public func requestAuthorization() async throws -> Bool {
        return try await service.requestAuthorization()
    }
    
    public func registerNotification() {
        service.registerNotification()
    }
    
    
    public func registerNotification() async {
        return await service.registerNotification()
    }
    
}
