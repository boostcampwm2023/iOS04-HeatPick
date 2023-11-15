//
//  SearchResultRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchResultInteractable: Interactable {
    var router: SearchResultRouting? { get set }
    var listener: SearchResultListener? { get set }
}

protocol SearchResultViewControllable: ViewControllable { }

final class SearchResultRouter: ViewableRouter<SearchResultInteractable, SearchResultViewControllable>, SearchResultRouting {

    override init(
        interactor: SearchResultInteractable,
        viewController: SearchResultViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    

}
