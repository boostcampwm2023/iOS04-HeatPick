//
//  StoryCreatorRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryCreatorInteractable: Interactable {
    var router: StoryCreatorRouting? { get set }
    var listener: StoryCreatorListener? { get set }
}

protocol StoryCreatorViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class StoryCreatorRouter: ViewableRouter<StoryCreatorInteractable, StoryCreatorViewControllable>, StoryCreatorRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: StoryCreatorInteractable, viewController: StoryCreatorViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
