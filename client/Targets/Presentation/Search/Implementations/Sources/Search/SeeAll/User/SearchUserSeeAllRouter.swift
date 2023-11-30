//
//  SearchUserSeeAllRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol SearchUserSeeAllInteractable: Interactable {
    var router: SearchUserSeeAllRouting? { get set }
    var listener: SearchUserSeeAllListener? { get set }
}

typealias SearchUserSeeAllViewControllable = UserSeeAllViewControllable

final class SearchUserSeeAllRouter: ViewableRouter<SearchUserSeeAllInteractable, SearchUserSeeAllViewControllable>, SearchUserSeeAllRouting {
    
    override init(interactor: SearchUserSeeAllInteractable, viewController: SearchUserSeeAllViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
    }
    
}
