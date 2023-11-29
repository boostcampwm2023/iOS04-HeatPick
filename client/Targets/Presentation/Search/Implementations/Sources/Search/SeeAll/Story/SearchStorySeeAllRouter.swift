//
//  SearchStorySeeAllRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol SearchStorySeeAllInteractable: Interactable {
    var router: SearchStorySeeAllRouting? { get set }
    var listener: SearchStorySeeAllListener? { get set }
}

typealias SearchStorySeeAllViewControllable = StorySeeAllViewControllable

final class SearchStorySeeAllRouter: ViewableRouter<SearchStorySeeAllInteractable, SearchStorySeeAllViewControllable>, SearchStorySeeAllRouting {

    
    override init(interactor: SearchStorySeeAllInteractable, viewController: SearchStorySeeAllViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
    }

}
