//
//  StoryDetailBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol StoryDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class StoryDetailComponent: Component<StoryDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol StoryDetailBuildable: Buildable {
    func build(withListener listener: StoryDetailListener) -> StoryDetailRouting
}

public final class StoryDetailBuilder: Builder<StoryDetailDependency>, StoryDetailBuildable {

    public override init(dependency: StoryDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryDetailListener) -> StoryDetailRouting {
        let component = StoryDetailComponent(dependency: dependency)
        let viewController = StoryDetailViewController()
        let interactor = StoryDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return StoryDetailRouter(interactor: interactor, viewController: viewController)
    }
}
