//
//  BeginEditingTextDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol BeginEditingTextDashboardInteractable: Interactable {
    var router: BeginEditingTextDashboardRouting? { get set }
    var listener: BeginEditingTextDashboardListener? { get set }
}

protocol BeginEditingTextDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BeginEditingTextDashboardRouter: ViewableRouter<BeginEditingTextDashboardInteractable, BeginEditingTextDashboardViewControllable>, BeginEditingTextDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BeginEditingTextDashboardInteractable, viewController: BeginEditingTextDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
