//
//  SearchContainerRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchContainerInteractable: Interactable {
    var router: SearchContainerRouting? { get set }
    var listener: SearchContainerListener? { get set }
}

protocol SearchContainerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchContainerRouter: ViewableRouter<SearchContainerInteractable, SearchContainerViewControllable>, SearchContainerRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchContainerInteractable, viewController: SearchContainerViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
