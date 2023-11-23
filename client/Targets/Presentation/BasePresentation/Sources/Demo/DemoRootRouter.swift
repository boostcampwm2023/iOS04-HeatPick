//
//  DemoRootRouter.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol DemoRootInteractable: Interactable {
    var router: DemoRootRouting? { get set }
}

public protocol DemoRootViewControllable: ViewControllable {}

public protocol DemoRootRouterListener: AnyObject {
    func demoRootRouterDidBecomeActive()
}

public final class DemoRootRouter: LaunchRouter<DemoRootInteractable, DemoRootViewControllable>, DemoRootRouting {
    
    public weak var listener: DemoRootRouterListener?
    
    override init(interactor: DemoRootInteractable, viewController: DemoRootViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    public func attach(execute: (ViewControllable) -> Void) {
        execute(viewController)
    }
    
    public func didBecomeActive() {
        listener?.demoRootRouterDidBecomeActive()
    }
    
}
