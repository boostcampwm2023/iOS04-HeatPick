//
//  SearchAfterDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//


import UIKit

import DesignKit
import ModernRIBs

protocol SearchAfterDashboardPresentableListener: AnyObject {
    
}

final class SearchAfterDashboardViewController: UIViewController, SearchAfterDashboardPresentable, SearchAfterDashboardViewControllable {

    weak var listener: SearchAfterDashboardPresentableListener?
    
    private enum Constant {
        static let contentInset: UIEdgeInsets = .init(top: 40, left: 0, bottom: 40, right: 0)
    }
    
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
        stackView.spacing = 60
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
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
    
    func insertDashboard(_ viewControllable: ViewControllable, at index: Int) {
        let viewController = viewControllable.uiviewController
        addChild(viewController)
        stackView.insertArrangedSubview(viewController.view, at: index)
        viewController.didMove(toParent: self)
    }
    
    func removeDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        stackView.removeArrangedSubview(viewController.view)
        viewController.removeFromParent()
    }
}

private extension SearchAfterDashboardViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }
    
}
