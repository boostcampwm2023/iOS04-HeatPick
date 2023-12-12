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

protocol AppRootPresentableListener: AnyObject {}

final class AppRootTabBarController: UITabBarController, AppRootPresentable, AppRootViewControllable {
    
    weak var listener: AppRootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hpWhite
        setupTabBar()
    }
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
    }
    
    func selectViewController(_ viewController: ViewControllable) {
        guard let index = viewControllers?.firstIndex(where: { controller in
            if let navigation = controller as? UINavigationController {
                return navigation.topViewController == viewController.uiviewController
                
            } else {
                return controller == viewController.uiviewController
            }
        }) else {
            return
        }
        selectedIndex = index
    }
    
    private func setupTabBar() {
        let appearance: UITabBarAppearance = tabBar.standardAppearance
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .hpWhite
        appearance.stackedItemPositioning = .automatic
        tabBar.isTranslucent = false
        tabBar.barStyle = .default
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .hpBlack
        tabBar.unselectedItemTintColor = .hpGray2
    }
    
}
