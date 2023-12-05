//
//  SignUpSuccessBuilder.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SignUpSuccessDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SignUpSuccessComponent: Component<SignUpSuccessDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SignUpSuccessBuildable: Buildable {
    func build(withListener listener: SignUpSuccessListener) -> SignUpSuccessRouting
}

final class SignUpSuccessBuilder: Builder<SignUpSuccessDependency>, SignUpSuccessBuildable {

    override init(dependency: SignUpSuccessDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpSuccessListener) -> SignUpSuccessRouting {
        let component = SignUpSuccessComponent(dependency: dependency)
        let viewController = SignUpSuccessViewController()
        let interactor = SignUpSuccessInteractor(presenter: viewController)
        interactor.listener = listener
        return SignUpSuccessRouter(interactor: interactor, viewController: viewController)
    }
    
}
