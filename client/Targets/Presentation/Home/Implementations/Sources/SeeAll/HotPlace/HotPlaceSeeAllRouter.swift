//
//  HotPlaceSeeAllRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import BasePresentation
import ModernRIBs

protocol HotPlaceSeeAllInteractable: Interactable {
    var router: HotPlaceSeeAllRouting? { get set }
    var listener: HotPlaceSeeAllListener? { get set }
}

typealias HotPlaceSeeAllViewControllable = StorySeeAllViewControllable

final class HotPlaceSeeAllRouter: ViewableRouter<HotPlaceSeeAllInteractable, HotPlaceSeeAllViewControllable>, HotPlaceSeeAllRouting {
    
    override init(interactor: HotPlaceSeeAllInteractable, viewController: HotPlaceSeeAllViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
