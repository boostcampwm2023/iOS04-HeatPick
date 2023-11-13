//
//  SignInBuilder.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainInterfaces

public protocol SignInDependency: Dependency {
    var signInUseCase: SignInUseCaseInterface { get }
}

final class SignInComponent: Component<SignInDependency>,
                            SignInInteractorDependency,
                            SignUpDependency {
    var signInUseCase: SignInUseCaseInterface { dependency.signInUseCase }
}

// MARK: - Builder

public protocol SignInBuildable: Buildable {
    func build(withListener listener: SignInListener) -> ViewableRouting
}

public final class SignInBuilder: Builder<SignInDependency>, SignInBuildable {

    public override init(dependency: SignInDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: SignInListener) -> ViewableRouting {
        let component = SignInComponent(dependency: dependency)
        let viewController = SignInViewController()
        
        let signUpBuilder: SignUpBuildable = SignUpBuilder(dependency: component)
        
        let interactor = SignInInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return SignInRouter(
            interactor: interactor,
            viewController: viewController,
            signUpBuilder: signUpBuilder
        )
    }
}
