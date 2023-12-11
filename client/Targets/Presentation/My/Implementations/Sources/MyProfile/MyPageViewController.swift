//
//  MyPageViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import CoreKit
import DesignKit
import BasePresentation

protocol MyPagePresentableListener: AnyObject {
    func viewWillAppear()
    func didTapSetting()
}

public final class MyPageViewController: BaseViewController, MyPagePresentable, MyPageViewControllable {
    
    weak var listener: MyPagePresentableListener?

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
    
    
    func setupNaviTitle(_ username: String) {
        navigationView.do {
            $0.setup(model: .init(
                title: "\(username)",
                leftButtonType: .none,
                rightButtonTypes: [.setting])
            )
        }
    }
    
}

extension MyPageViewController: NavigationViewDelegate {
    
    public func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        if case .setting = type { listener?.didTapSetting() }
    }
    
}

private extension MyPageViewController {
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
}
