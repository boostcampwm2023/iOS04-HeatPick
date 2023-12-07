//
//  StoryCreateSuccessRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryCreateSuccessInteractable: Interactable {
    var router: StoryCreateSuccessRouting? { get set }
    var listener: StoryCreateSuccessListener? { get set }
}

protocol StoryCreateSuccessViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class StoryCreateSuccessRouter: ViewableRouter<StoryCreateSuccessInteractable, StoryCreateSuccessViewControllable>, StoryCreateSuccessRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: StoryCreateSuccessInteractable, viewController: StoryCreateSuccessViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
