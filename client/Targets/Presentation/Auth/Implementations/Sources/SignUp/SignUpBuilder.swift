//
//  SignUpBuilder.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SignUpDependency: Dependency {
    var authUseCase: AuthUseCaseInterface { get }
}

final class SignUpComponent: Component<SignUpDependency>, SignUpInteractorDependency {
    var authUseCase: AuthUseCaseInterface { dependency.authUseCase }
}

// MARK: - Builder

protocol SignUpBuildable: Buildable {
    func build(withListener listener: SignUpListener) -> SignUpRouting
}

final class SignUpBuilder: Builder<SignUpDependency>, SignUpBuildable {

    override init(dependency: SignUpDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpListener) -> SignUpRouting {
        let component = SignUpComponent(dependency: dependency)
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return SignUpRouter(interactor: interactor, viewController: viewController)
    }
}
