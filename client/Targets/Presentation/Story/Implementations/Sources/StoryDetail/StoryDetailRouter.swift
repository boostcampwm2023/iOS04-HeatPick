//
//  StoryDetailRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryDetailInteractable: Interactable {
    var router: StoryDetailRouting? { get set }
    var listener: StoryDetailListener? { get set }
}

protocol StoryDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class StoryDetailRouter: ViewableRouter<StoryDetailInteractable, StoryDetailViewControllable>, StoryDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: StoryDetailInteractable, viewController: StoryDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
