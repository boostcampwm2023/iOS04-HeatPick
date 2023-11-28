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


protocol SearchResultPresentableListener: AnyObject {
    func editing(_ text: String)
    func endEditing(_ text: String)
    func detachSearchResult()
    func attachSearchBeforeDashboard()
    func detachSearchBeforeDashboard()
    func attachSearchingDashboard()
    func detachSearchingDashboard()
    func attachSearchAfterDashboard()
    func detachSearchAfterDashboard()
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
        listener?.attachSearchBeforeDashboard()
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
    
}

private extension SearchResultViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
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
    
    func editing(_ text: String) {
        listener?.editing(text)
    }
    
    func showSearchBeforeDashboard() {
        Log.make(message: "\(String(describing: self)) \(#function)", log: .default)
        listener?.detachSearchingDashboard()
        listener?.attachSearchBeforeDashboard()
    }
    
    func showSearchingDashboard() {
        Log.make(message: "\(String(describing: self)) \(#function)", log: .default)
        listener?.detachSearchAfterDashboard()
        listener?.detachSearchBeforeDashboard()
        listener?.attachSearchingDashboard()
    }
    
    func showSearchAfterDashboard(_ text: String) {
        Log.make(message: "\(String(describing: self)) \(#function)", log: .default)
        listener?.endEditing(text)
        listener?.detachSearchingDashboard()
        listener?.attachSearchAfterDashboard()
    }
    
    func leftButtonDidTap() {
        listener?.detachSearchResult()
    }
    
}
