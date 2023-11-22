//
//  MyPageViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

protocol MyPagePresentableListener: AnyObject {
    func didTapSetting()
}

public final class MyPageViewController: UIViewController, MyPagePresentable, MyPageViewControllable {
    
    private enum Constant {
        static let tabBarTitle = "마이"
        static let tabBarImage = "person"
        static let tabBarImageSelected = "person.fill"
        static let contentInset: UIEdgeInsets = .init(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    weak var listener: MyPagePresentableListener?
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.setup(model: .init(
            title: "마이페이지",
            leftButtonType: .none,
            rightButtonTypes: [.setting])
        )
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .zero
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = Constant.contentInset
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        stackView.addArrangedSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
        
    func removeDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        stackView.removeArrangedSubview(viewController.view)
        viewController.removeFromParent()
    }
    
}

extension MyPageViewController: NavigationViewDelegate {
    
    public func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        guard case .setting = type else { return }
        listener?.didTapSetting()
    }
    
}

private extension MyPageViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
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
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
}
