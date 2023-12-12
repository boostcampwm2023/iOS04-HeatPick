//
//  SearchBeforeRecentSearchesDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import ModernRIBs
import CoreKit
import DesignKit

protocol SearchBeforeRecentSearchesDashboardPresentableListener: AnyObject {
    func recentSearchViewDidTap(_ recentSearch: String)
    func recentSearchViewDelete(_ recentSearch: String)
}

final class SearchBeforeRecentSearchesDashboardViewController: UIViewController, SearchBeforeRecentSearchesDashboardPresentable, SearchBeforeRecentSearchesDashboardViewControllable {

    weak var listener: SearchBeforeRecentSearchesDashboardPresentableListener?
    
    private enum Constant {
        enum HeaderView {
            static let topOffset: CGFloat = 20
            static let bottomOffset: CGFloat = -topOffset
            static let title = "최근 검색어"
        }
        
        enum EmptyView {
            static let topOffset: CGFloat = 20
            static let bottomOffset: CGFloat = -topOffset
        }
        
        enum StackView {
            static let spacing: CGFloat = 10
        }
    }
    
    private let headerView: SearchBeforeHeaderView = {
       let headerView = SearchBeforeHeaderView()
        headerView.setupTitle(Constant.HeaderView.title)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private let emptyView: SearchBeforeRecentSearchesEmptyView = {
        let emptyView = SearchBeforeRecentSearchesEmptyView()
        emptyView.isHidden = true
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isHidden = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = Constant.StackView.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
        
    func setup(models: [String]) {
        let isEmpty = models.isEmpty
        emptyView.isHidden = !isEmpty
        scrollView.isHidden = isEmpty
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        models.forEach { model in
            let contentView = SearchBeforeRecentSearchView()
            contentView.setup(model)
            contentView.delegate = self
            stackView.insertArrangedSubview(contentView, at: 0)
        }
    }
    
}


private extension SearchBeforeRecentSearchesDashboardViewController {
    
    func setupViews() {
        [headerView, emptyView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.HeaderView.topOffset),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.EmptyView.topOffset),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.EmptyView.bottomOffset),
            
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.HeaderView.topOffset),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
}

extension SearchBeforeRecentSearchesDashboardViewController: searchBeforeRecentSearchViewDelegate {
    
    func recentSearchViewDidTap(_ recentSearch: String) {
        listener?.recentSearchViewDidTap(recentSearch)
    }
    
    func recentSearchViewDelete(_ recentSearch: String) {
        listener?.recentSearchViewDelete(recentSearch)
    }
    
}
