//
//  SettingInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import FoundationKit
import ModernRIBs

protocol SettingRouting: ViewableRouting {
    func attachResignDashboard()
    func detachResignDashboard()
}

protocol SettingPresentable: Presentable {
    var listener: SettingPresentableListener? { get set }
    func openURL(_ url: URL)
    func openSettingApp()
    func updateLocationSubtitle(_ subtitle: String)
    func updateNotificationSubtitle(_ subtitle: String)
}

protocol SettingListener: AnyObject {
    func settingDidTapClose()
}

final class SettingInteractor: PresentableInteractor<SettingPresentable>, SettingInteractable, SettingPresentableListener {
    
    weak var router: SettingRouting?
    weak var listener: SettingListener?
    
    private let dependency: SettingInteractorDependency
    private let cancelBag = CancelBag()
    
    init(
        presenter: SettingPresentable,
        dependency: SettingInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        updatePermission()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.settingDidTapClose()
    }
    
    func didTapDiscussion() {
        let discussionURL = "https://github.com/boostcampwm2023/iOS04-HeatPick/discussions/293"
        guard let url = URL(string: discussionURL) else { return }
        presenter.openURL(url)
    }
    
    func didTapLocation() {
        switch dependency.locationAuthorityUseCase.permission {
        case .authorized:
            presenter.updateLocationSubtitle("있음")
            
        case .denied:
            presenter.openSettingApp()
            presenter.updateLocationSubtitle("없음")
            
            
        default:
            dependency.locationAuthorityUseCase.requestPermission()
            presenter.updateLocationSubtitle("없음")
        }
    }
    
    func didTapNotification() {
        Task { [weak self] in
            guard let self else { return }
            
            let authorized = try await dependency.notificationPermissionUseCase.requestAuthorization()
            if authorized {
                await dependency.notificationPermissionUseCase.registerNotification()
                await MainActor.run { [weak self] in
                    self?.presenter.updateNotificationSubtitle("있음")
                }
                
            } else {
                await MainActor.run { [weak self] in
                    self?.presenter.updateNotificationSubtitle("없음")
                    self?.presenter.openSettingApp()
                }
            }
        }.store(in: cancelBag)
        
    }
    
    func didTapResign() {
        router?.attachResignDashboard()
    }
    
    func didTapSignOut() {
        dependency.signOutRequestService.signOut(type: .signOut)
    }
    
    func didTapBack() {
        router?.detachResignDashboard()
    }
    
    func resign() {
        dependency.signOutRequestService.signOut()
    }
    
    private func updatePermission() {
        let locationPermission = dependency.locationAuthorityUseCase.permission
        let notificationPermission = dependency.notificationPermissionUseCase.settings?.authorizationStatus
        
        switch locationPermission {
        case .authorized:
            presenter.updateLocationSubtitle("있음")
            
        default:
            presenter.updateLocationSubtitle("없음")
        }
        
        switch notificationPermission {
        case .authorized:
            presenter.updateNotificationSubtitle("있음")
            
        default:
            presenter.updateNotificationSubtitle("없음")
        }
    }
    
}
