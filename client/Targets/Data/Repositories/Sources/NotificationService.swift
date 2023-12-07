//
//  NotificationService.swift
//  DataRepositories
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainInterfaces

public typealias NotificationService = PushService

extension NotificationService: NotificationServiceInterface {}
