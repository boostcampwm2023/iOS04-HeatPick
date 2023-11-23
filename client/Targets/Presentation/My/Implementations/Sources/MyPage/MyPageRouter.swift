//
//  MyPageRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces

protocol MyPageInteractable: Interactable,
                             MyPageUserDashboardListener,
                             MyPageStoryDashboardListener,
                             MyPageStorySeeAllListener,
                             SettingListener {
    var router: MyPageRouting? { get set }
    var listener: MyPageListener? { get set }
}

protocol MyPageViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class MyPageRouter: ViewableRouter<MyPageInteractable, MyPageViewControllable>, MyPageRouting {
    
    private let userDashboardBuilder: MyPageUserDashboardBuildable
    private var userDashboardRouting: ViewableRouting?
    
    private let storyDashboardBuilder: MyPageStoryDashboardBuildable
    private var storyDashboardRouting: ViewableRouting?
    
    private let storySeeAllBuilder: MyPageStorySeeAllBuildable
    private var storySeeAllRouting: ViewableRouting?
    
    private let settingBuilder: SettingBuildable
    private var settingRouting: SettingRouting?
    
    init(
        interactor: MyPageInteractable,
        viewController: MyPageViewControllable,
        userDashboardBuilder: MyPageUserDashboardBuildable,
        storyDashboardBuilder: MyPageStoryDashboardBuildable,
        storySeeAllBuilder: MyPageStorySeeAllBuildable,
        settingBuilder: SettingBuildable
    ) {
        self.userDashboardBuilder = userDashboardBuilder
        self.storyDashboardBuilder = storyDashboardBuilder
        self.storySeeAllBuilder = storySeeAllBuilder
        self.settingBuilder = settingBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachUserDashboard() {
        guard userDashboardRouting == nil else { return }
        let router = userDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.userDashboardRouting = router
        attachChild(router)
    }
    
    func detachUserDashboard() {
        guard let router = userDashboardRouting else { return }
        viewController.removeDashboard(router.viewControllable)
        self.userDashboardRouting = nil
        detachChild(router)
    }
    
    func attachStoryDashboard() {
        guard storyDashboardRouting == nil else { return }
        let router = storyDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.storyDashboardRouting = router
        attachChild(router)
    }
    
    func detachStoryDashboard() {
        guard let router = storyDashboardRouting else { return }
        viewController.removeDashboard(router.viewControllable)
        self.storyDashboardRouting = nil
        detachChild(router)
    }
    
    func attachStorySeeAll() {
        guard storySeeAllRouting == nil else { return }
        let router = storySeeAllBuilder.build(withListener: interactor)
        viewControllable.pushViewController(router.viewControllable, animated: true)
        self.storySeeAllRouting = router
        attachChild(router)
    }
    
    func detachStorySeeAll() {
        guard let router = storySeeAllRouting else { return }
        viewController.popViewController(animated: true)
        self.storySeeAllRouting = nil
        detachChild(router)
    }
    
    func attachSetting() {
        guard settingRouting == nil else { return }
        let router = settingBuilder.build(withListener: interactor)
        viewController.pushViewController(router.viewControllable, animated: true)
        self.settingRouting = router
        attachChild(router)
    }
    
    func detachSetting() {
        guard let router = settingRouting else { return }
        viewController.popViewController(animated: true)
        self.settingRouting = nil
        detachChild(router)
    }
    
}
