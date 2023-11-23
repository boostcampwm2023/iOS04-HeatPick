//
//  SearchAfterUserDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import ModernRIBs

protocol SearchAfterUserDashboardPresentableListener: AnyObject {
    func searchAfterHeaderViewSeeAllViewDidTap()
}

struct SearchAfterUserDashboardViewModel {
    let contentList: [SearchAfterUserViewModel]
}

final class SearchAfterUserDashboardViewController: UIViewController, SearchAfterUserDashboardPresentable, SearchAfterUserDashboardViewControllable {
    
    weak var listener: SearchAfterUserDashboardPresentableListener?
    
    private enum Constant {
        static let offset: CGFloat = 20
        
        enum HeaderView {
            static let title = "유저"
        }
        
        enum EmptyView {
            static let title = "검색어에 해당되는 유저가 없어요"
            static let subTitle = "친구에게 HeatPick을 추천해보세요"
        }
        
        enum StackView {
            static let spacing: CGFloat = 15
        }
    }
    private lazy var headerView: SearchAfterHeaderView = {
        let headerView = SearchAfterHeaderView()
        headerView.delegate = self
        headerView.setupTitle(Constant.HeaderView.title)
        headerView.isHiddenSeeAllView(true)
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
        stackView.distribution = .equalSpacing
        stackView.spacing = Constant.StackView.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(model: SearchAfterUserDashboardViewModel) {
        let isEmpty = model.contentList.isEmpty
        headerView.isHiddenSeeAllView(isEmpty)
        emptyView.isHidden = !isEmpty
        scrollView.isHidden = isEmpty
        model.contentList.forEach { model in
            let contentView = SearchAfterUserView()
            contentView.setup(model: model)
            stackView.addArrangedSubview(contentView)
        }
    }
    
}

private extension SearchAfterUserDashboardViewController {
    func setupViews() {
        [headerView, emptyView, scrollView].forEach { view.addSubview($0) }
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.offset),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.offset),
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

extension SearchAfterUserDashboardViewController: SearchAfterHeaderViewDelegate {
    
    func searchAfterHeaderViewSeeAllViewDidTap() {
        listener?.searchAfterHeaderViewSeeAllViewDidTap()
    }
    
}
