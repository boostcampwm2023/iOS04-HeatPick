//
//  AppService.swift
//  DataRepositories
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class AppService: AppServiceInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func updatePushToken(token: String) async -> Result<Void, Error> {
        let target = AppAPI.updatePushToken(token: token)
        return await session.request(target)
    }
    
}
