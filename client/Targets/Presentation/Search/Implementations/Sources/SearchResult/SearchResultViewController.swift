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
    
    private lazy var searchNavigationView: SearchNavigationView = {
        let navigationView = SearchNavigationView()
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension SearchResultViewController {
    func setupViews() {
        
        view.addSubview(searchNavigationView)
        NSLayoutConstraint.activate([
            searchNavigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchNavigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight)
        ])
        
    }
}

extension SearchResultViewController: SearchNavigationViewDelegate {
    func leftButtonDidTap() {
        listener?.naviagtionViewBackButtonDidTap()
    }   
}
