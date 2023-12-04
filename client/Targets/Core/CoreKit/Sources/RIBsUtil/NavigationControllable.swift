//
//  NavigationControllable.swift
//  CoreKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import ModernRIBs

public final class NavigationControllable: ViewControllable {
    
    public var uiviewController: UIViewController { navigationController }
    public let navigationController: UINavigationController
    
    public init(viewControllable: ViewControllable) {
        let navigationController = SwipeNavigationController(rootViewController: viewControllable.uiviewController)
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
    }
    
}
