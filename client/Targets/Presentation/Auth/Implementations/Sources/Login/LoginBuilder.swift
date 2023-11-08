//
//  LoginBuilder.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol LoginDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoginComponent: Component<LoginDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener) -> Routing
}

public final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    public override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: LoginListener) -> Routing {
        let component = LoginComponent(dependency: dependency)
        let viewController = LoginViewController()
        let interactor = LoginInteractor(presenter: viewController)
        interactor.listener = listener
        return LoginRouter(interactor: interactor, viewController: viewController)
    }
}
