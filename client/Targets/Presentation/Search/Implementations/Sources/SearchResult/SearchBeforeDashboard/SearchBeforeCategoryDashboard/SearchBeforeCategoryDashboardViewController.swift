//
//  SearchBeforeCategoryDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DesignKit
import CoreKit
import UIKit

protocol SearchBeforeCategoryDashboardPresentableListener: AnyObject {
    func didTapSearchBeforeRecentSearchesView()
}

final class SearchBeforeCategoryDashboardViewController: UIViewController, SearchBeforeCategoryDashboardPresentable, SearchBeforeCategoryDashboardViewControllable {
    
    weak var listener: SearchBeforeCategoryDashboardPresentableListener?
    
    private enum Constant {
        enum HeaderView {
            static let topOffset: CGFloat = 20
            static let bottomOffset: CGFloat = -topOffset
            static let title = "카테고리"
        }
        
        enum EmptyView {
            static let topOffset: CGFloat = 20
            static let bottomOffset: CGFloat = -topOffset
            static let title = "카테고리가 없어요"
            static let subTitle = "조금만 기다려주시면 카테고리를 추가할게요"
        }
        
        enum ScrollView {
            static let topOffset: CGFloat = 10
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
    
    private let emptyView: SearchResultEmptyView = {
        let emptyView = SearchResultEmptyView()
        emptyView.setup(model: .init(
            title: Constant.EmptyView.title,
            subtitle: Constant.EmptyView.subTitle)
        )
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
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constant.StackView.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setup(models: [SearchBeforeCategoryViewModel]) {
        let isEmpty = models.isEmpty
        emptyView.isHidden = !isEmpty
        scrollView.isHidden = isEmpty
        models.forEach { model in
            let contentView = SearchBeforeCategoryView()
            contentView.setup(model)
            contentView.delegate = self
            stackView.addArrangedSubview(contentView)
        }
    }

}

private extension SearchBeforeCategoryDashboardViewController {
    func setupViews() {
        [headerView, emptyView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.HeaderView.topOffset),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.HeaderView.topOffset),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension SearchBeforeCategoryDashboardViewController: SearchBeforeCategoryViewDelegate {
    
    func didTapSearchBeforeCategoryView() {
        listener?.didTapSearchBeforeRecentSearchesView()
    }
    
}
