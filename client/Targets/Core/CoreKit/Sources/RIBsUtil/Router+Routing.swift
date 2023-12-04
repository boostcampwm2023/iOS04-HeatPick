//
//  Router+Routing.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import ModernRIBs

public extension ViewableRouting {
    
    // MARK: - Attach
    
    func presentRouter(
        _ router: ViewableRouting,
        animated: Bool,
        isFullScreen: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        viewControllable.present(router.viewControllable, animated: animated, isFullScreen: isFullScreen, completion: completion)
        attachChild(router)
    }
    
    func pushRouter(_ router: ViewableRouting, animated: Bool) {
        viewControllable.pushViewController(router.viewControllable, animated: animated)
        attachChild(router)
    }
    
    func setRouters(_ routers: [ViewableRouting], animated: Bool) {
        viewControllable.setViewControllers(routers.map(\.viewControllable), animated: animated)
        routers.forEach(attachChild)
    }
    
    // MARK: - Detach
    
    func dismissRouter(_ router: ViewableRouting, animated: Bool, completion: (() -> Void)? = nil) {
        viewControllable.dismiss(animated: animated, completion: completion)
        detachChild(router)
    }
    
    func popRouter(_ router: ViewableRouting, animated: Bool, completion: (() -> Void)? = nil) {
        viewControllable.popViewController(router.viewControllable, animated: animated, completion: completion)
        detachChild(router)
    }
    
}
