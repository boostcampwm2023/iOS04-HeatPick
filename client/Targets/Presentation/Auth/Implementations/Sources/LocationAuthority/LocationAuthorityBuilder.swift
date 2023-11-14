//
//  LocationAuthorityBuilder.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol LocationAuthorityDependency: Dependency {
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { get }
}

final class LocationAuthorityComponent: Component<LocationAuthorityDependency>, LocationAuthorityInteractorDependency {
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { dependency.locationAuthorityUseCase }
    

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
        let interactor = LocationAuthorityInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return LocationAuthorityRouter(interactor: interactor, viewController: viewController)
    }
}
