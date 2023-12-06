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

final class StoryCreateSuccessComponent: Component<StoryCreateSuccessDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let component = StoryCreateSuccessComponent(dependency: dependency)
        let viewController = StoryCreateSuccessViewController()
        let interactor = StoryCreateSuccessInteractor(presenter: viewController)
        interactor.listener = listener
        return StoryCreateSuccessRouter(interactor: interactor, viewController: viewController)
    }
}
