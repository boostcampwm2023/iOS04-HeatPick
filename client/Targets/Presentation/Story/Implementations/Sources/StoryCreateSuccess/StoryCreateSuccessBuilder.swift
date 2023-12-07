//
//  StoryCreateSuccessBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainEntities

protocol StoryCreateSuccessDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class StoryCreateSuccessComponent: Component<StoryCreateSuccessDependency>,
                                         StoryCreateSuccessInteractorDependency {

    let badgeInfo: BadgeExp
    init(dependency: StoryCreateSuccessDependency, badgeInfo: BadgeExp) {
        self.badgeInfo = badgeInfo
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol StoryCreateSuccessBuildable: Buildable {
    func build(withListener listener: StoryCreateSuccessListener, badgeInfo: BadgeExp) -> StoryCreateSuccessRouting
}

final class StoryCreateSuccessBuilder: Builder<StoryCreateSuccessDependency>, StoryCreateSuccessBuildable {

    override init(dependency: StoryCreateSuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StoryCreateSuccessListener, badgeInfo: BadgeExp) -> StoryCreateSuccessRouting {
        let component = StoryCreateSuccessComponent(dependency: dependency, badgeInfo: badgeInfo)
        let viewController = StoryCreateSuccessViewController()
        let interactor = StoryCreateSuccessInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return StoryCreateSuccessRouter(interactor: interactor, viewController: viewController)
    }
}
