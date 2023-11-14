//
//  ViewControllable+Routing.swift
//  CoreKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import ModernRIBs

public extension ViewControllable {
    
    func present(
        _ viewControllable: ViewControllable,
        animated: Bool,
        isFullScreen: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        if isFullScreen {
            viewControllable.uiviewController.modalPresentationStyle = .overFullScreen
        }
        uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }
    
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }
    
    func setViewControllers(_ viewControllables: [ViewControllable], animated: Bool) {
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.setViewControllers(viewControllables.map(\.uiviewController), animated: animated)
        } else {
            uiviewController.navigationController?.setViewControllers(viewControllables.map(\.uiviewController), animated: animated)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        uiviewController.dismiss(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool) {
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.popViewController(animated: animated)
        } else {
            uiviewController.navigationController?.popViewController(animated: animated)
        }
    }
    
}
