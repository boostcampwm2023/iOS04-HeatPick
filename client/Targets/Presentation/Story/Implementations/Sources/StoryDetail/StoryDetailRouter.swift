//
//  StoryDetailRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import StoryInterfaces

protocol StoryDetailInteractable: Interactable {
    var router: StoryDetailRouting? { get set }
    var listener: StoryDetailListener? { get set }
}

protocol StoryDetailViewControllable: ViewControllable {}

final class StoryDetailRouter: ViewableRouter<StoryDetailInteractable, StoryDetailViewControllable>, StoryDetailRouting {

    override init(interactor: StoryDetailInteractable, viewController: StoryDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
