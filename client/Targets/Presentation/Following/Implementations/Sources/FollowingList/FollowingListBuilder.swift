//
//  FollowingListBuilder.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol FollowingListDependency: Dependency {
    var followingUseCase: FollowingUseCaseInterface { get }
}

final class FollowingListComponent: Component<FollowingListDependency>, FollowingListInteractorDependency {
    var followingUseCase: FollowingUseCaseInterface { dependency.followingUseCase }
}

protocol FollowingListBuildable: Buildable {
    func build(withListener listener: FollowingListListener) -> FollowingListRouting
}

final class FollowingListBuilder: Builder<FollowingListDependency>, FollowingListBuildable {
    
    override init(dependency: FollowingListDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: FollowingListListener) -> FollowingListRouting {
        let component = FollowingListComponent(dependency: dependency)
        let viewController = FollowingListViewController()
        let interactor = FollowingListInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return FollowingListRouter(interactor: interactor, viewController: viewController)
    }
    
}
