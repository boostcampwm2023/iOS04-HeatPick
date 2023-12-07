//
//  AppUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainInterfaces

public final class AppUseCase: AppUseCaseInterface {
    
    private let service: AppServiceInterface
    private let pushService: PushService
    private let cancelBag = CancelBag()
    
    public init(
        service: AppServiceInterface,
        pushService: PushService
    ) {
        self.service = service
        self.pushService = pushService
        self.pushService.listener = self
    }
    
    public func registerFcmToken(token: String) {
        Task { [weak self] in
            await self?.service.updatePushToken(token: token)
                .onSuccess {
                    Log.make(message: "토큰 저장 성공", log: .network)
                }
                .onFailure { error in
                    Log.make(message: "토큰 저장 실패: \(error.localizedDescription)", log: .network)
                }
        }
    }
    
    public func updateToken() {
        pushService.updateToken()
    }
    
    public func register(deviceToken: Data) {
        pushService.register(deviceToken: deviceToken)
    }
    
}

extension AppUseCase: PushServiceListener {
    
    public func pushServiceDidReceiveToken(_ serivce: PushService, token: String) {
        registerFcmToken(token: token)
    }
    
}
