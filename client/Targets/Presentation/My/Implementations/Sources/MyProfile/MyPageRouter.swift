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
                             ProfileStoryDashboardListener,
                             ProfileStoryDashboardSeeAllListener,
                             SettingListener,
                             StoryDetailListener,
                             MyProfileUpdateUserDashboardListener { 
    var router: MyPageRouting? { get set }
    var listener: MyPageListener? { get set }
}

protocol MyPageViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class MyPageRouter: ViewableRouter<MyPageInteractable, MyPageViewControllable>, MyPageRouting {

    private var userDashboardRouting: MyPageUserDashboardRouting?
    private var storyDashboardRouting: ProfileStoryDashboardRouting?
    private var storySeeAllRouting: ViewableRouting?
    private var settingRouting: ViewableRouting?
    private var storyDetailRouting: ViewableRouting?
    private var updateUserDashoardRouting: ViewableRouting?
    
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
    
    // MARK: Story
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
        pushRouter(router, animated: true)
        self.storySeeAllRouting = router
    }
    
    func detachStorySeeAll() {
        guard let router = storySeeAllRouting else { return }
        popRouter(router, animated: true)
        self.storySeeAllRouting = nil
    }
    
    func attachStoryDetail(storyId: Int) {
        guard storyDetailRouting == nil else { return }
        let router = dependency.storyDetailBuilder.build(withListener: interactor, storyId: storyId)
        pushRouter(router, animated: true)
        self.storyDetailRouting = router
    }
    
    func detachStoryDetail() {
        guard let router = storyDetailRouting else { return }
        popRouter(router, animated: true)
        self.storyDetailRouting = nil
    }
    
    // MARK: Setting
    func attachSetting() {
        guard settingRouting == nil else { return }
        let router = dependency.settingBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        self.settingRouting = router
    }
    
    func detachSetting() {
        guard let router = settingRouting else { return }
        popRouter(router, animated: true)
        self.settingRouting = nil
    }
    
    // MARK: UpdateProfile
    func attachupdateUserDashboard() {
        guard updateUserDashoardRouting == nil else { return }
        let router = dependency.updateUserDashboardBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        updateUserDashoardRouting = router
    }
    
    func detachUpdateUserDashboard() {
        guard let router = updateUserDashoardRouting else { return }
        popRouter(router, animated: true)
        updateUserDashoardRouting = nil
    }
    
}
