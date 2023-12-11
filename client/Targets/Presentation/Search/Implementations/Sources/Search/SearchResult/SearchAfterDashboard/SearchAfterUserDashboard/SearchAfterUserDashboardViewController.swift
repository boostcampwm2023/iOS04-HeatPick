//
//  SearchAfterUserDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import DesignKit
import DomainEntities

protocol SearchAfterUserDashboardPresentableListener: AnyObject {
    func searchUserSeeAllDidTap()
    func didTapUser(userId: Int)
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
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
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
    
    func setup(models: [SearchUser]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let isEmpty = models.isEmpty
        headerView.isHiddenSeeAllView(isEmpty)
        models.forEach { model in
            let contentView = SearchAfterUserView()
            contentView.setup(model: model)
            contentView.delegate = self
            stackView.addArrangedSubview(contentView)
        }
        emptyView.isHidden = !isEmpty
    }
    
}

private extension SearchAfterUserDashboardViewController {
    func setupViews() {
        [headerView, emptyView, stackView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.offset),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.offset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension SearchAfterUserDashboardViewController: SearchAfterHeaderViewDelegate {

    func searchAfterSeeAllViewDidTap() {
        listener?.searchUserSeeAllDidTap()
    }
    
}

extension SearchAfterUserDashboardViewController: SearchAfterUserViewDelegate {
    
    func didTapUser(userId: Int) {
        listener?.didTapUser(userId: userId)
    }
    
}
