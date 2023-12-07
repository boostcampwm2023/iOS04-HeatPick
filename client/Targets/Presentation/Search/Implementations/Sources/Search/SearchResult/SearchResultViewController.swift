//
//  SearchResultViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

import ModernRIBs

import CoreKit
import DesignKit
import BasePresentation


protocol SearchResultPresentableListener: AnyObject {
    func editing(_ searchText: String)
    
    func showSearchBeforeDashboard()
    func showSearchingDashboard()
    func showSearchAfterDashboard(searchText: String)
    
    func detachSearchResult()
}

final class SearchResultViewController: BaseViewController, SearchResultPresentable, SearchResultViewControllable {
    
    weak var listener: SearchResultPresentableListener?
    
    private let searchNavigationView = SearchNavigationView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener?.showSearchBeforeDashboard()
    }
    
    func appendDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        
        if let view = stackView.arrangedSubviews.filter({ $0 == viewController.view }).first {
            view.isHidden = false
        } else {
            addChild(viewController)
            stackView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    func removeDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        stackView.removeArrangedSubview(viewController.view)
        viewController.removeFromParent()
    }
    
    func setSearchText(_ searchText: String) {
        searchNavigationView.setSearchText(searchText)
    }
    
    override func setupLayout() {
        [searchNavigationView, stackView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            searchNavigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchNavigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            stackView.topAnchor.constraint(equalTo: searchNavigationView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        searchNavigationView.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        
    }
    
}

extension SearchResultViewController: SearchNavigationViewDelegate {
    
    func editing(_ searchText: String) {
        listener?.editing(searchText)
    }
    
    func showSearchBeforeDashboard() {
        listener?.showSearchBeforeDashboard()
    }
    
    func showSearchingDashboard() {
        listener?.showSearchingDashboard()
    }
    
    func showSearchAfterDashboard(_ searchText: String) {
        listener?.showSearchAfterDashboard(searchText: searchText)
    }
    
    func didTapBack() {
        listener?.detachSearchResult()
    }
    
}

extension SearchResultViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.detachSearchResult()
    }
    
}
