//
//  StoryDetailBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainEntities
import DomainInterfaces

public protocol StoryDetailDependency: Dependency {
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryDetailComponent: Component<StoryDetailDependency>, StoryDetailInteractorDependency {
    
    let storyId: Int
    var storyUseCase: StoryUseCaseInterface {
        dependency.storyUseCase
    }
    
    init(dependency: StoryDetailDependency, storyId: Int) {
        self.storyId = storyId
        super.init(dependency: dependency)
    }
    
}

// MARK: - Builder

public protocol StoryDetailBuildable: Buildable {
    func build(withListener listener: StoryDetailListener, storyId: Int) -> StoryDetailRouting
}

public final class StoryDetailBuilder: Builder<StoryDetailDependency>, StoryDetailBuildable {

    public override init(dependency: StoryDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryDetailListener, storyId: Int) -> StoryDetailRouting {
        let component = StoryDetailComponent(dependency: dependency, storyId: storyId)
        let viewController = StoryDetailViewController()
        let interactor = StoryDetailInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return StoryDetailRouter(interactor: interactor, viewController: viewController)
    }
    
}
