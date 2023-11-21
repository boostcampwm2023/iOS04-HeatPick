//
//  EditingTextDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol EditingTextDashboardInteractable: Interactable {
    var router: EditingTextDashboardRouting? { get set }
    var listener: EditingTextDashboardListener? { get set }
}

protocol EditingTextDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class EditingTextDashboardRouter: ViewableRouter<EditingTextDashboardInteractable, EditingTextDashboardViewControllable>, EditingTextDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: EditingTextDashboardInteractable, viewController: EditingTextDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
