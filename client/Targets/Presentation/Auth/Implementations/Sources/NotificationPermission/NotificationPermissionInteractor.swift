//
//  NotificationPermissionInteractor.swift
//  AuthImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainInterfaces

protocol NotificationPermissionRouting: ViewableRouting {}

protocol NotificationPermissionPresentable: Presentable {
    var listener: NotificationPermissionPresentableListener? { get set }
    func openSettingApp()
}

protocol NotificationPermissionListener: AnyObject {
    func notificationPermissionDidComplete()
    func notificationPermissionDidSkip()
}

protocol NotificationPermissionInteractorDependency: AnyObject {
    var notificationPermissionUseCase: NotificationPermissionUseCaseInterface { get }
}

final class NotificationPermissionInteractor: PresentableInteractor<NotificationPermissionPresentable>, NotificationPermissionInteractable, NotificationPermissionPresentableListener {
    
    weak var router: NotificationPermissionRouting?
    weak var listener: NotificationPermissionListener?
    
    private let dependency: NotificationPermissionInteractorDependency
    private let cancelBag = CancelBag()
    
    init(
        presenter: NotificationPermissionPresentable,
        dependency: NotificationPermissionInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapNext() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let authorized = try await dependency.notificationPermissionUseCase.requestAuthorization()
                await dependency.notificationPermissionUseCase.registerNotification()
                
                await MainActor.run {
                    if authorized {
                        self.listener?.notificationPermissionDidComplete()
                    } else {
                        self.presenter.openSettingApp()
                    }
                }
            } catch {
                Log.make(message: error.localizedDescription, log: .interactor)
            }
            
        }
    }
    
    func didTapSkip() {
        listener?.notificationPermissionDidSkip()
    }
    
}
