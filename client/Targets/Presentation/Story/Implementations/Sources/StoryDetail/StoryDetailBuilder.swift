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
import StoryInterfaces
import MyInterfaces

public protocol StoryDetailDependency: Dependency {
    var storyUseCase: StoryUseCaseInterface { get }
    var userProfileBuilder: UserProfileBuildable { get }
}

final class StoryDetailComponent: Component<StoryDetailDependency>,
                                  StoryDetailRouterDependency,
                                  StoryDetailInteractorDependency,
                                  CommentDependency {
    
    let storyId: Int
    var storyUseCase: StoryUseCaseInterface {
        dependency.storyUseCase
    }
    
    lazy var commentBuilder: CommentBuildable = {
       return CommentBuilder(dependency: self)
    }()
    
    var userProfileBuilder: UserProfileBuildable {
        dependency.userProfileBuilder
    }
    
    init(dependency: StoryDetailDependency, storyId: Int) {
        self.storyId = storyId
        super.init(dependency: dependency)
    }
    
}

// MARK: - Builder
public final class StoryDetailBuilder: Builder<StoryDetailDependency>, StoryDetailBuildable {

    public override init(dependency: StoryDetailDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryDetailListener, storyId: Int) -> ViewableRouting {
        let component = StoryDetailComponent(dependency: dependency, storyId: storyId)
        let viewController = StoryDetailViewController()
        let interactor = StoryDetailInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return StoryDetailRouter(interactor: interactor, viewController: viewController, dependency: component)
    }
    
}
