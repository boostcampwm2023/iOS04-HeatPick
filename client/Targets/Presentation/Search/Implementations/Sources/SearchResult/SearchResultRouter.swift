//
//  SearchResultRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchResultInteractable: Interactable,
                                   BeginEditingTextDashboardListener,
                                   EditingTextDashboardListener,
                                    EndEditingTextDashboardListener {
    var router: SearchResultRouting? { get set }
    var listener: SearchResultListener? { get set }
}

protocol SearchResultViewControllable: ViewControllable {
    func attachDashboard(_ viewControllable: ViewControllable)
    func detachDashboard(_ viewControllable: ViewControllable)
}

protocol SearchResultRouterDependency {
    var beginEditingTextDashboardBuilder: BeginEditingTextDashboardBuildable { get }
    var editingTextDashboardBuilder: EditingTextDashboardBuildable { get }
    var endEditingTextDashboardBuilder: EndEditingTextDashboardBuildable { get }
}

final class SearchResultRouter: ViewableRouter<SearchResultInteractable, SearchResultViewControllable>, SearchResultRouting {
    
    private let beginEditingTextDashboardBuilder: BeginEditingTextDashboardBuildable
    private var beginEditingTextDasboardRouter: BeginEditingTextDashboardRouting?
    
    private let editingTextDashboardBuilder: EditingTextDashboardBuildable
    private var editingTextDashboardRouter: EditingTextDashboardRouting?
    
    private let endEditingTextDashboardBuilder: EndEditingTextDashboardBuildable
    private var endEditingTextDashboardRouter: EndEditingTextDashboardRouting?
    
    init(
        interactor: SearchResultInteractable,
        viewController: SearchResultViewControllable,
        dependency: SearchResultRouterDependency
    ) {
        self.beginEditingTextDashboardBuilder = dependency.beginEditingTextDashboardBuilder
        self.editingTextDashboardBuilder = dependency.editingTextDashboardBuilder
        self.endEditingTextDashboardBuilder = dependency.endEditingTextDashboardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachBeginEditingTextDashboard() {
        guard beginEditingTextDasboardRouter == nil else { return }
        let router = beginEditingTextDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        beginEditingTextDasboardRouter = router
    }
    
    func detachBeginEditingTextDashboard() {
        guard let router = beginEditingTextDasboardRouter else { return }
        detachChild(router)
        beginEditingTextDasboardRouter = nil
    }
    
    func attachEditingTextDashboard() {
        guard editingTextDashboardRouter == nil else { return }
        let router = editingTextDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        editingTextDashboardRouter = router
    }
    
    func detachEditingTextDashboard() {
        guard let router = editingTextDashboardRouter else { return }
        detachChild(router)
        editingTextDashboardRouter = nil
    }
    
    func attachEndEditingTextDashboard() {
        guard endEditingTextDashboardRouter == nil else { return }
        let router = endEditingTextDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        endEditingTextDashboardRouter = router
    }
    
    func detachEndEditingTextDashboard() {
        guard let router = endEditingTextDashboardRouter else { return }
        detachChild(router)
        endEditingTextDashboardRouter = nil
    }
    
    func showBeginEditingTextDashboard() {
        guard let beginEditingTextDasboardRouter else { return }
        viewController.attachDashboard(beginEditingTextDasboardRouter.viewControllable)
    }
    
    func hideBeginEditingTextDashboard() {
        guard let beginEditingTextDasboardRouter else { return }
        viewController.detachDashboard(beginEditingTextDasboardRouter.viewControllable)
    }
    
    func showEditingTextDashboard() {
        guard let editingTextDashboardRouter else { return }
        viewController.attachDashboard(editingTextDashboardRouter.viewControllable)
    }
    
    func hideEditingTextDashboard() {
        guard let editingTextDashboardRouter else { return }
        viewController.detachDashboard(editingTextDashboardRouter.viewControllable)
    }
    
    func showEndEditingTextDashboard() {
        guard let endEditingTextDashboardRouter else { return }
        viewController.attachDashboard(endEditingTextDashboardRouter.viewControllable)
    }
    
    func hideEndEditingTextDashboard() {
        guard let endEditingTextDashboardRouter else { return }
        viewController.detachDashboard(endEditingTextDashboardRouter.viewControllable)
    }
    
}
