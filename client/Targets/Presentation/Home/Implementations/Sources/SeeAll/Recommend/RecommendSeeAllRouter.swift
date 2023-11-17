//
//  RecommendSeeAllRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import BasePresentation
import ModernRIBs

protocol RecommendSeeAllInteractable: Interactable {
    var router: RecommendSeeAllRouting? { get set }
    var listener: RecommendSeeAllListener? { get set }
}

typealias RecommendSeeAllViewControllable = StorySeeAllViewControllable

final class RecommendSeeAllRouter: ViewableRouter<RecommendSeeAllInteractable, RecommendSeeAllViewControllable>, RecommendSeeAllRouting {
    
    override init(interactor: RecommendSeeAllInteractable, viewController: RecommendSeeAllViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
