//
//  StoryCreatorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol StoryCreatorDependency: Dependency {}

final class StoryCreatorComponent: Component<StoryCreatorDependency>,
                                   StoryCreatorRouterDependency,
                                   StoryEditorDependency {

    lazy var storyEditorBuilder: StoryEditorBuildable = {
        StoryEditorBuilder(dependency: self)
    }()
}

// MARK: - Builder

public protocol StoryCreatorBuildable: Buildable {
    func build(withListener listener: StoryCreatorListener) -> StoryCreatorRouting
}

public final class StoryCreatorBuilder: Builder<StoryCreatorDependency>, StoryCreatorBuildable {

    public override init(dependency: StoryCreatorDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryCreatorListener) -> StoryCreatorRouting {
        let component = StoryCreatorComponent(dependency: dependency)
        let viewController = StoryCreatorViewController()
        let interactor = StoryCreatorInteractor(presenter: viewController)
        interactor.listener = listener
        
        return StoryCreatorRouter(interactor: interactor,
                                  viewController: viewController,
                                  dependency: component)
    }
    
}
