//
//  SearchMapRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchMapInteractable: Interactable {
    var router: SearchMapRouting? { get set }
    var listener: SearchMapListener? { get set }
}

protocol SearchMapViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchMapRouter: ViewableRouter<SearchMapInteractable, SearchMapViewControllable>, SearchMapRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchMapInteractable, viewController: SearchMapViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
