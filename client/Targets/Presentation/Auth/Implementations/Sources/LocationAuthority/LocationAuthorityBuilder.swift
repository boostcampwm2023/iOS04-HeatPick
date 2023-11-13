//
//  LocationAuthorityBuilder.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol LocationAuthorityDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LocationAuthorityComponent: Component<LocationAuthorityDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LocationAuthorityBuildable: Buildable {
    func build(withListener listener: LocationAuthorityListener) -> LocationAuthorityRouting
}

final class LocationAuthorityBuilder: Builder<LocationAuthorityDependency>, LocationAuthorityBuildable {

    override init(dependency: LocationAuthorityDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LocationAuthorityListener) -> LocationAuthorityRouting {
        let component = LocationAuthorityComponent(dependency: dependency)
        let viewController = LocationAuthorityViewController()
        let interactor = LocationAuthorityInteractor(presenter: viewController)
        interactor.listener = listener
        return LocationAuthorityRouter(interactor: interactor, viewController: viewController)
    }
}
