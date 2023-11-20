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
    private var beginEditingTextDasboardRouter: Routing?
    
    private let editingTextDashboardBuilder: EditingTextDashboardBuildable
    private var editingTextDashboardRouter: Routing?
    
    private let endEditingTextDashboardBuilder: EndEditingTextDashboardBuildable
    private var endEditingTextDashboardRouter: Routing?
    
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
    
    
}
