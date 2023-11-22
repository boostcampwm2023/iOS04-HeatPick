//
//  MyPageStorySeeAllRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol MyPageStorySeeAllInteractable: Interactable {
    var router: MyPageStorySeeAllRouting? { get set }
    var listener: MyPageStorySeeAllListener? { get set }
}

typealias MyPageStorySeeAllViewControllable = StorySeeAllViewControllable

final class MyPageStorySeeAllRouter: ViewableRouter<MyPageStorySeeAllInteractable, MyPageStorySeeAllViewControllable>, MyPageStorySeeAllRouting {
    
    override init(interactor: MyPageStorySeeAllInteractable, viewController: MyPageStorySeeAllViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
