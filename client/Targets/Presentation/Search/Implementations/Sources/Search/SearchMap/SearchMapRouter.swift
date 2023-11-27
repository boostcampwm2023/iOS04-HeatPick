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

protocol SearchMapViewControllable: ViewControllable {}

final class SearchMapRouter: ViewableRouter<SearchMapInteractable, SearchMapViewControllable>, SearchMapRouting {
    
    override init(interactor: SearchMapInteractable, viewController: SearchMapViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
