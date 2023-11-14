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
    func naviagtionViewBackButtonDidTap()
}

final class SearchResultViewController: UIViewController, SearchResultPresentable, SearchResultViewControllable {
    
    weak var listener: SearchResultPresentableListener?
    
    // TODO: SearchController로 변경
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        let model = NavigationViewModel(title: "검색", leftButtonType: .back, rightButtonTypes: [])
        navigationView.setup(model: model)
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hpGray3
        setupViews()
    }
}

private extension SearchResultViewController {
    func setupViews() {
        
        view.addSubview(navigationView)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight)
        ])
        
    }
}

extension SearchResultViewController: NavigationViewDelegate {
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.naviagtionViewBackButtonDidTap()
    }
    
    
}
