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
    func showBeginEditingTextDashboard()
    func hideBeginEditingTextDashboard()
    func showEditingTextDashboard()
    func hideEditingTextDashboard()
    func showEndEditingTextDashboard()
    func hideEndEditingTextDashboard()
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
        listener?.showBeginEditingTextDashboard()
    }
    
    func attachDashboard(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        
        if let view = stackView.arrangedSubviews.filter({ $0 == viewController.view }).first {
            view.isHidden = false
        } else {
            addChild(viewController)
            stackView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    func detachDashboard(_ viewControllable: ViewControllable) {
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
        listener?.hideEditingTextDashboard()
        listener?.showBeginEditingTextDashboard()
    }
    
    func showEditingTextDashboard() {
        listener?.hideEndEditingTextDashboard()
        listener?.hideBeginEditingTextDashboard()
        listener?.showEditingTextDashboard()
    }
    
    func showEndEditingTextDashboard(_ text: String) {
        listener?.hideEditingTextDashboard()
        listener?.showEndEditingTextDashboard()
    }
    
    func leftButtonDidTap() {
        listener?.detachSearchResult()
    }
    
}
