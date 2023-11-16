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
    private var previousTabIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
    }
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        super.setViewControllers(viewControllers.map(\.uiviewController), animated: false)
    }
    
    func selectPreviousTab() {
        guard let numberOfTabs = viewControllers?.count,
              (0..<numberOfTabs) ~= previousTabIndex else {
            return
        }
        selectedIndex = previousTabIndex
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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabIndex = tabBar.items?.firstIndex(of: item), tabIndex != 2 else { return }
        previousTabIndex = tabIndex
    }
}
