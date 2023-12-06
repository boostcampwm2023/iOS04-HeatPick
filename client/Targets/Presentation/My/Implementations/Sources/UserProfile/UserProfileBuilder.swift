//
//  UserProfileBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol UserProfileDependency: Dependency {
    var userProfileUserCaseInterface: UserProfileUserCaseInterface { get }
}

final class UserProfileComponent: Component<UserProfileDependency> {

    
}

// MARK: - Builder


final class UserProfileBuilder: Builder<UserProfileDependency>, UserProfileBuildable {

    override init(dependency: UserProfileDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: UserProfileListener) -> UserProfileRouting {
        let component = UserProfileComponent(dependency: dependency)
        let interactor = UserProfileInteractor()
        interactor.listener = listener
        return UserProfileRouter(interactor: interactor, viewController: component.UserProfileViewController)
    }
}
