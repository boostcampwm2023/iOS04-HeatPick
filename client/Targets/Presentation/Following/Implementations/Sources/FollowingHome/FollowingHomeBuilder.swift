//
//  FollowingHomeBuilder.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces
import FollowingInterfaces
import StoryInterfaces

public protocol FollowingHomeDependency: Dependency {
    var followingUseCase: FollowingUseCaseInterface { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
}

final class FollowingHomeComponent: Component<FollowingHomeDependency>, FollowingListDependency {
    var followingUseCase: FollowingUseCaseInterface { dependency.followingUseCase }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
}

public final class FollowingHomeBuilder: Builder<FollowingHomeDependency>, FollowingHomeBuildable {
    
    public override init(dependency: FollowingHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: FollowingHomeListener) -> ViewableRouting {
        let component = FollowingHomeComponent(dependency: dependency)
        let viewController = FollowingHomeViewController()
        let interactor = FollowingHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return FollowingHomeRouter(
            interactor: interactor,
            viewController: viewController,
            followingListBuilder: FollowingListBuilder(dependency: component),
            storyDetailBuilder: component.storyDetailBuilder
        )
    }
    
}
