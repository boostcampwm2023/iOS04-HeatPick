//
//  FollowingHomeBuilder.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import FollowingInterfaces

public protocol FollowingHomeDependency: Dependency {}

final class FollowingHomeComponent: Component<FollowingHomeDependency> {}

public final class FollowingHomeBuilder: Builder<FollowingHomeDependency>, FollowingHomeBuildable {
    
    public override init(dependency: FollowingHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: FollowingHomeListener) -> ViewableRouting {
        let component = FollowingHomeComponent(dependency: dependency)
        let viewController = FollowingHomeViewController()
        let interactor = FollowingHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return FollowingHomeRouter(interactor: interactor, viewController: viewController)
    }
    
}
