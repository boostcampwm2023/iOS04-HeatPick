//
//  SearchAfterStoryDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import DesignKit
import DomainEntities

protocol SearchAfterStoryDashboardPresentableListener: AnyObject {
    func searchStorySeeAllDidTap()
    func didTapStory(storyId: Int)
}

final class SearchAfterStoryDashboardViewController: UIViewController, SearchAfterStoryDashboardPresentable, SearchAfterStoryDashboardViewControllable {
    
    private enum Constant {
        static let offset: CGFloat = 20
        
        enum TitleView {
            static let title = "스토리"
        }
        
        enum EmptyView {
            static let title = "검색어에 해당하는 스토리가 없어요"
            static let subTitle = "해당 키워드로 첫 스토리를 작성해보세요"
        }
        
        enum StackView {
            static let spacing: CGFloat = 15
        }
    }
    
    weak var listener: SearchAfterStoryDashboardPresentableListener?
    
    private lazy var headerView: SearchAfterHeaderView = {
        let titleView = SearchAfterHeaderView()
        titleView.delegate = self
        titleView.setupTitle(Constant.TitleView.title)
        titleView.isHiddenSeeAllView(true)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
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
    
    func setup(models: [SearchStory]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let isEmpty = models.isEmpty
        headerView.isHiddenSeeAllView(isEmpty)
        models.forEach { model in
            let contentView = SearchAfterStoryView()
            contentView.setup(model: model)
            contentView.delegate = self
            self.stackView.addArrangedSubview(contentView)
        }
        emptyView.isHidden = !isEmpty
    }
    
}

private extension SearchAfterStoryDashboardViewController {
    func setupViews() {
        [headerView, emptyView, stackView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.offset),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constant.offset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension SearchAfterStoryDashboardViewController: SearchAfterHeaderViewDelegate {
    
    func searchAfterSeeAllViewDidTap() {
        listener?.searchStorySeeAllDidTap()
    }
    
}

extension SearchAfterStoryDashboardViewController: SearchAfterStoryViewDelegate {
    
    func didTapStory(storyId: Int) {
        listener?.didTapStory(storyId: storyId)
    }
    
}
