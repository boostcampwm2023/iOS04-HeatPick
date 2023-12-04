//
//  LocationAuthorityRouter.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol LocationAuthorityInteractable: Interactable {
    var router: LocationAuthorityRouting? { get set }
    var listener: LocationAuthorityListener? { get set }
}

protocol LocationAuthorityViewControllable: ViewControllable {}

final class LocationAuthorityRouter: ViewableRouter<LocationAuthorityInteractable, LocationAuthorityViewControllable>, LocationAuthorityRouting {
    
    override init(interactor: LocationAuthorityInteractable, viewController: LocationAuthorityViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
