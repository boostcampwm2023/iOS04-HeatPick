//
//  StoryCreateSuccessInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainEntities

protocol StoryCreateSuccessRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol StoryCreateSuccessPresentable: Presentable {
    var listener: StoryCreateSuccessPresentableListener? { get set }
    func setup(_ model: StoryCreateSuccessViewModel)
}

protocol StoryCreateSuccessListener: AnyObject {
    func successConfirmButtonDidTap()
}

protocol StoryCreateSuccessInteractorDependency: AnyObject {
    var badgeInfo: BadgeExp { get }
}

final class StoryCreateSuccessInteractor: PresentableInteractor<StoryCreateSuccessPresentable>,
                                          StoryCreateSuccessInteractable,
                                          StoryCreateSuccessPresentableListener {
    
    weak var router: StoryCreateSuccessRouting?
    weak var listener: StoryCreateSuccessListener?
    private let dependency: StoryCreateSuccessInteractorDependency
    
    init(presenter: StoryCreateSuccessPresentable, dependency: StoryCreateSuccessInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func viewDidAppear() {
        presenter.setup(StoryCreateSuccessViewModel(badge: dependency.badgeInfo.name,
                                                    prevExp: dependency.badgeInfo.prevExp,
                                                    exp: dependency.badgeInfo.nowExp))
    }
    
    func confirmButtonDidTap() {
        listener?.successConfirmButtonDidTap()
    }
}
