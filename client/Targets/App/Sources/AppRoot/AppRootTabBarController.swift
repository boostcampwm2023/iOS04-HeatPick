//
//  AppRootViewController.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DesignKit
import UIKit

protocol AppRootPresentableListener: AnyObject {
    
}

final class AppRootTabBarController: UITabBarController, AppRootPresentable, AppRootViewControllable {

    weak var listener: AppRootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .hpBlack
        tabBar.backgroundColor = .hpWhite
    }
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
    }
}
