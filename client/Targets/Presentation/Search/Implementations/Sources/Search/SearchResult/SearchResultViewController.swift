//
//  SearchResultViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import ModernRIBs

protocol SearchResultPresentableListener: AnyObject {
    func detachSearchResult()
    func showSearchBeforeDashboard()
    func hideSearchBeforeDashboard()
    func showSearchingDashboard()
    func hideSearchingDashboard()
    func showSearchAfterDashboard()
    func hideSearchAfterDashboard()
}

final class SearchResultViewController: UIViewController, SearchResultPresentable, SearchResultViewControllable {

    weak var listener: SearchResultPresentableListener?
    
    private lazy var searchNavigationView: SearchNavigationView = {
        let navigationView = SearchNavigationView()
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
        guard let view = stackView.arrangedSubviews.filter({ $0 == viewController.view }).first else { return }
        view.isHidden = true
    }
    
}

private extension SearchResultViewController {
    
    func setupViews() {
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
    
}

extension SearchResultViewController: SearchNavigationViewDelegate {
    
    func showBeginEditingTextDashboard() {
        listener?.hideSearchingDashboard()
        listener?.showSearchBeforeDashboard()
    }
    
    func showEditingTextDashboard() {
        listener?.hideSearchAfterDashboard()
        listener?.hideSearchBeforeDashboard()
        listener?.showSearchingDashboard()
    }
    
    func showEndEditingTextDashboard(_ text: String) {
        listener?.hideSearchingDashboard()
        listener?.showSearchAfterDashboard()
    }
    
    func leftButtonDidTap() {
        listener?.detachSearchResult()
    }
    
}
