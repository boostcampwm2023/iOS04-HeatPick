//
//  SearchHomeListRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchHomeListInteractable: Interactable {
    var router: SearchHomeListRouting? { get set }
    var listener: SearchHomeListListener? { get set }
}

protocol SearchHomeListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchHomeListRouter: ViewableRouter<SearchHomeListInteractable, SearchHomeListViewControllable>, SearchHomeListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchHomeListInteractable, viewController: SearchHomeListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
