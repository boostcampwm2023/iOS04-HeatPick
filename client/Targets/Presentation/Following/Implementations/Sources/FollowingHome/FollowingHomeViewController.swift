//
//  FollowingHomeViewController.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import ModernRIBs

protocol FollowingHomePresentableListener: AnyObject {}

final class FollowingHomeViewController: UIViewController, FollowingHomePresentable, FollowingHomeViewControllable {
    
    private enum Constant {
        static let tabBarTitle = "팔로잉"
        static let tabBarImage = "person.3"
        static let tabBarImageSelected = "person.3.fill"
        static let contentInset: UIEdgeInsets = .init(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    weak var listener: FollowingHomePresentableListener?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func removeDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
}

private extension FollowingHomeViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
    }
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
}
