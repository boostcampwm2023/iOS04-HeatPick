//
//  EndEditingTextDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol EndEditingTextDashboardInteractable: Interactable {
    var router: EndEditingTextDashboardRouting? { get set }
    var listener: EndEditingTextDashboardListener? { get set }
}

protocol EndEditingTextDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EndEditingTextDashboardRouter: ViewableRouter<EndEditingTextDashboardInteractable, EndEditingTextDashboardViewControllable>, EndEditingTextDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EndEditingTextDashboardInteractable, viewController: EndEditingTextDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
