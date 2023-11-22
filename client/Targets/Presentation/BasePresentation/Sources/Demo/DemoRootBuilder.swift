//
//  DemoRootBuilder.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol DemoRootDependency: Dependency {}

public final class DemoRootComponent: Component<EmptyDependency>, DemoRootDependency {
    
    public init() {
        super.init(dependency: EmptyComponent())
    }
    
}

protocol DemoRootBuildable: Buildable {
    func build() -> DemoRootRouter
}

public final class DemoRootBuilder: Builder<DemoRootDependency>, DemoRootBuildable {

    public override init(dependency: DemoRootDependency) {
        super.init(dependency: dependency)
    }

    public func build() -> DemoRootRouter {
        let component = DemoRootComponent()
        let viewController = DemoRootViewController()
        let interactor = DemoRootInteractor(presenter: viewController)
        return DemoRootRouter(interactor: interactor, viewController: viewController)
    }
    
}
