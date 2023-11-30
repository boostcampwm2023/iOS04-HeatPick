//
//  MyPageRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces
import StoryInterfaces

protocol MyPageInteractable: Interactable,
                             MyPageUserDashboardListener,
                             MyPageStoryDashboardListener,
                             MyPageStorySeeAllListener,
                             SettingListener,
                             StoryDetailListener,
                             UserInfoEditDashboardListener { 
    var router: MyPageRouting? { get set }
    var listener: MyPageListener? { get set }
}

protocol MyPageViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class MyPageRouter: ViewableRouter<MyPageInteractable, MyPageViewControllable>, MyPageRouting {
    
    private var userDashboardRouting: ViewableRouting?
    private var storyDashboardRouting: ViewableRouting?
    private var storySeeAllRouting: ViewableRouting?
    private var settingRouting: ViewableRouting?
    private var storyDetailRouting: ViewableRouting?
    private var userInfoEditDashboardRouting: ViewableRouting?
    
    private let dependency: MypageRouterDependency
    
    init(
        interactor: MyPageInteractable,
        viewController: MyPageViewControllable,
        dependency: MypageRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachUserDashboard() {
        guard userDashboardRouting == nil else { return }
        let router = dependency.userDashboardBuilder.build(withListener: interactor)
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
        let router = dependency.storyDashboardBuilder.build(withListener: interactor)
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
    
    func attachStorySeeAll(userId: Int) {
        guard storySeeAllRouting == nil else { return }
        let router = dependency.storySeeAllBuilder.build(withListener: interactor, userId: userId)
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
        let router = dependency.settingBuilder.build(withListener: interactor)
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
    
    func attachStoryDetail(id: Int) {
        guard storyDetailRouting == nil else { return }
        let router = dependency.storyDetailBuilder.build(withListener: interactor, storyId: id)
        viewController.pushViewController(router.viewControllable, animated: true)
        self.storyDetailRouting = router
        attachChild(router)
    }
    
    func detachStoryDetail() {
        guard let router = storyDetailRouting else { return }
        viewController.popViewController(animated: true)
        self.storyDetailRouting = nil
        detachChild(router)
    }

    func attachUserInfoEditDashboard() {
        guard userInfoEditDashboardRouting == nil else { return }
        let router = dependency.userInfoEditDashboardBuilder.build(withListener: interactor)
        viewController.pushViewController(router.viewControllable, animated: true)
        userInfoEditDashboardRouting = router
        attachChild(router)
    }
    
    func detachUserInfoEditDashboard() {
        guard let router = userInfoEditDashboardRouting else { return }
        viewController.popViewController(animated: true)
        detachChild(router)
        userInfoEditDashboardRouting = nil
    }
    
}
