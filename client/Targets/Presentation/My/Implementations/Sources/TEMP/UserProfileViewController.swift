//
//  UserProfileViewController.swift
//  MyImplementations
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import CoreKit
import DesignKit
import BasePresentation

protocol UserProfilePresentableListener: AnyObject {
    func viewWillAppear()
    func didTapBack()
}

final class UserProfileViewController: BaseViewController, UserProfilePresentable, UserProfileViewControllable {

    weak var listener: UserProfilePresentableListener?
    
    private enum Constant {
        static let tabBarTitle = "마이"
        static let tabBarImage = "person"
        static let tabBarImageSelected = "person.fill"
        static let contentInset: UIEdgeInsets = .init(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.viewWillAppear()
    }
    
    func setDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        addChild(viewController)
        stackView.addArrangedSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
        
    func removeDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        stackView.removeArrangedSubview(viewController.view)
        viewController.removeFromParent()
    }
    
    public override func setupLayout() {
        [navigationView, scrollView].forEach(view.addSubview)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    public override func setupAttributes() {
        view.backgroundColor = .hpWhite
                
        scrollView.do {
            $0.contentInset = .zero
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentInset = Constant.contentInset
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 40
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        navigationView.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setMyProfile(_ username: String) {
        navigationView.do {
            $0.setup(model: .init(
                title: "\(username)",
                leftButtonType: .none,
                rightButtonTypes: [.setting])
            )
        }
    }
    
    func setUserProfile(_ username: String) {
        navigationView.do {
            $0.setup(model: .init(
                title: "\(username)",
                leftButtonType: .back,
                rightButtonTypes: [])
            )
        }
    }
    
}

extension UserProfileViewController: NavigationViewDelegate {
    
    public func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        if case .back = type { listener?.didTapBack() }
    }
    
}

private extension UserProfileViewController {
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
}
