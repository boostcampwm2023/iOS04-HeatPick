//
//  UserProfileBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces

public final class UserProfileBuilder: Builder<UserProfileDependency>, UserProfileBuildable {

    public override init(dependency: UserProfileDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: UserProfileListener, userId: Int) -> ViewableRouting {
        let component = UserProfileComponent(dependency: dependency, userId: userId)
        let viewController = UserProfileViewController()
        let interactor = UserProfileInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        
        return UserProfileRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: UserProfileRouterComponent(component: component)
        )
    }
    
}
