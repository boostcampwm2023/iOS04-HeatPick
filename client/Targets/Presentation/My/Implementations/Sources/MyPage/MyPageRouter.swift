//
//  MyPageRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces

protocol MyPageInteractable: Interactable, MyPageUserDashboardListener, MyPageStoryDashboardListener {
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
    
    init(
        interactor: MyPageInteractable,
        viewController: MyPageViewControllable,
        userDashboardBuilder: MyPageUserDashboardBuildable,
        storyDashboardBuilder: MyPageStoryDashboardBuildable
    ) {
        self.userDashboardBuilder = userDashboardBuilder
        self.storyDashboardBuilder = storyDashboardBuilder
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
    
}
