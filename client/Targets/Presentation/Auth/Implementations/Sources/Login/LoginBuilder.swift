//
//  LoginBuilder.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainInterfaces

public protocol LoginDependency: Dependency {
    var loginUseCase: LoginUseCaseInterface { get }
}

final class LoginComponent: Component<LoginDependency>,
                            LoginInteractorDependency,
                            SignUpDependency {
    var loginUseCase: LoginUseCaseInterface { dependency.loginUseCase }
}

// MARK: - Builder

public protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener) -> ViewableRouting
}

public final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    public override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: LoginListener) -> ViewableRouting {
        let component = LoginComponent(dependency: dependency)
        let viewController = LoginViewController()
        
        let signUpBuilder: SignUpBuildable = SignUpBuilder(dependency: component)
        
        let interactor = LoginInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return LoginRouter(
            interactor: interactor,
            viewController: viewController,
            signUpBuilder: signUpBuilder
        )
    }
}
