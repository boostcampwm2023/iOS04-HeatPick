//
//  UserProfileRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces
import StoryInterfaces

protocol UserProfileInteractable: Interactable,
                                  UserProfileUserDashboardListener,
                                  MyPageStoryDashboardListener,
                                  MyPageStorySeeAllListener,
                                  StoryDetailListener {
    var router: UserProfileRouting? { get set }
    var listener: UserProfileListener? { get set }
}

protocol UserProfileViewControllable: ProfileViewControllable {
    func setUserProfile(_ username: String)
}

final class UserProfileRouter: ViewableRouter<UserProfileInteractable, UserProfileViewControllable>, UserProfileRouting {
        
    private var userDashboardRouting: UserProfileUserDashboardRouting?
    private var storyDashboardRouting: MyPageStoryDashboardRouting?
    private var storySeeAllRouting: ViewableRouting?
    private var settingRouting: ViewableRouting?
    private var storyDetailRouting: ViewableRouting?
    private var updateUserDashoardRouting: ViewableRouting?

    
    private let dependency: UserProfileRouterDependency
    
    init(
        interactor: UserProfileInteractable,
        viewController: UserProfileViewControllable,
        dependency: UserProfileRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func setUserProfile(_ username: String) {
        viewController.setUserProfile(username)
        userDashboardRouting?.setUserProfile()
        storyDashboardRouting?.setUserProfile(username)
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
        pushRouter(router, animated: true)
        self.storySeeAllRouting = router
    }
    
    func detachStorySeeAll() {
        guard let router = storySeeAllRouting else { return }
        popRouter(router, animated: true)
        self.storySeeAllRouting = nil
    }
    
    func attachStoryDetail(id: Int) {
        guard storyDetailRouting == nil else { return }
        let router = dependency.storyDetailBuilder.build(withListener: interactor, storyId: id)
        pushRouter(router, animated: true)
        self.storyDetailRouting = router
    }
    
    func detachStoryDetail() {
        guard let router = storyDetailRouting else { return }
        popRouter(router, animated: true)
        self.storyDetailRouting = nil
    }
    
}
