//
//  SettingRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SettingInteractable: Interactable,
                              ResignDashboardListener {
    var router: SettingRouting? { get set }
    var listener: SettingListener? { get set }
}

protocol SettingViewControllable: ViewControllable { }

final class SettingRouter: ViewableRouter<SettingInteractable, SettingViewControllable>, SettingRouting {
    
    private let dependency: SettingRouterDependency
    
    private var resignDashboardRouter: ViewableRouting?
    
    init(
        interactor: SettingInteractable, 
        viewController: SettingViewControllable,
        dependency: SettingRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachResignDashboard() {
        guard resignDashboardRouter == nil else { return }
        let router = dependency.resignDashboardBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        resignDashboardRouter = router
    }
    
    func detachResignDashboard() {
        guard let router = resignDashboardRouter else { return }
        popRouter(router, animated: true)
        resignDashboardRouter = nil
    }
    
}
