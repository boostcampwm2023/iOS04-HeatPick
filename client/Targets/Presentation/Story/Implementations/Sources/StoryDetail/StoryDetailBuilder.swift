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

final class StoryDetailComponent: Component<StoryDetailDependency> {
    
    let story: Story
    var storyUseCase: StoryUseCaseInterface {
        dependency.storyUseCase
    }
    
    init(dependency: StoryDetailDependency, story: Story) {
        self.story = story
        super.init(dependency: dependency)
    }
    
}

// MARK: - Builder

public protocol StoryDetailBuildable: Buildable {
    func build(withListener listener: StoryDetailListener, story: Story) -> StoryDetailRouting
}

public final class StoryDetailBuilder: Builder<StoryDetailDependency>, StoryDetailBuildable {

    public override init(dependency: StoryDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryDetailListener, story: Story) -> StoryDetailRouting {
        let component = StoryDetailComponent(dependency: dependency, story: story)
        let viewController = StoryDetailViewController()
        let interactor = StoryDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return StoryDetailRouter(interactor: interactor, viewController: viewController)
    }
    
}
