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
        viewControllable.uiviewController.hidesBottomBarWhenPushed = true
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
        uiviewController.resign()
        uiviewController.dismiss(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool) {
        if let navigationController = uiviewController as? UINavigationController {
            navigationController.topViewController?.resign()
            navigationController.popViewController(animated: animated)
        } else {
            uiviewController.navigationController?.topViewController?.resign()
            uiviewController.navigationController?.popViewController(animated: animated)
        }
    }
    
}

private extension UIViewController {
    
    /// 'resign'은 RIBs Keyboard Memory Leak 을 해결하기 위한 메소드 입니다.
    ///
    /// 'resign'은 ViewController가 pop 또는 dismiss 되기 전에 호출하여 Keyboard에 대한 소유권을 잃게 합니다.
    /// 연관 링크: https://github.com/boostcampwm2023/iOS04-HeatPick/issues/149
    func resign() {
        view.endEditing(true)
    }
    
}
