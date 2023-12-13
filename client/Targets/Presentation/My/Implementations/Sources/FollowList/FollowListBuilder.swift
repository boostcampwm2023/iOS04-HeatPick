//
//  FollowListBuilder.swift
//  MyImplementations
//
//  Created by jungmin lim on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

enum FollowType: String {
    case follower = "팔로워"
    case following = "팔로잉"
}

protocol FollowListDependency: Dependency {
    var myProfileUseCase: MyProfileUseCaseInterface { get }
    var userProfileUseCase: UserProfileUseCaseInterface { get }
}

final class FollowListComponent: Component<FollowListDependency>,
                                 FollowListInteractorDependency {
    var userId: Int?
    let type: FollowType
    var myProfileUseCase: MyProfileUseCaseInterface {
        dependency.myProfileUseCase
    }
    var userProfileUseCase: UserProfileUseCaseInterface {
        dependency.userProfileUseCase
    }
    
    init(dependency: FollowListDependency, type: FollowType, userId: Int?) {
        self.userId = userId
        self.type = type
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol FollowListBuildable: Buildable {
    func build(withListener listener: FollowListListener, type: FollowType, userId: Int?) -> ViewableRouting
}

final class FollowListBuilder: Builder<FollowListDependency>, FollowListBuildable {

    override init(dependency: FollowListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FollowListListener, type: FollowType, userId: Int?) -> ViewableRouting {
        let component = FollowListComponent(dependency: dependency, type: type, userId: userId)
        let viewController = FollowListViewController()
        let interactor = FollowListInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return FollowListRouter(interactor: interactor, viewController: viewController)
    }
}
