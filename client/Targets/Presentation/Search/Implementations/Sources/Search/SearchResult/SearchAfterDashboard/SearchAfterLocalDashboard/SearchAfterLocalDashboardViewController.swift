//
//  SearchAfterLocalDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import DesignKit
import DomainEntities

protocol SearchAfterLocalDashboardPresentableListener: AnyObject {
    func didTap(local: SearchLocal)
}

final class SearchAfterLocalDashboardViewController: UIViewController, SearchAfterLocalDashboardPresentable, SearchAfterLocalDashboardViewControllable {
    
    weak var listener: SearchAfterLocalDashboardPresentableListener?
    
    private enum Constant {
        static let offset: CGFloat = 20
        
        enum TitleView {
            static let title = "위치"
        }
        
        enum EmptyView {
            static let title = "검색어에 해당하는 위치정보가 없어요"
            static let subTitle = "검색어를 다시 입력해보세요"
        }
        
        enum StackView {
            static let spacing: CGFloat = 15
        }
    }
    
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
    
    func setup(models: [SearchLocal]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let isEmpty = models.isEmpty
        headerView.isHiddenSeeAllView(true) // 일단 모두 보기 보여주지 않음
        models.forEach { model in
            let contentView = SearchAfterLocalView()
            contentView.setup(model: model)
            contentView.delegate = self
            self.stackView.addArrangedSubview(contentView)
        }
        emptyView.isHidden = !isEmpty
    }
    
}

private extension SearchAfterLocalDashboardViewController {
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

extension SearchAfterLocalDashboardViewController: SearchAfterHeaderViewDelegate {
    
    func searchAfterSeeAllViewDidTap() {
        
    }
    
}

extension SearchAfterLocalDashboardViewController: SearchAfterLocalViewDelegate {
    
    func searchAfterLocalViewDidTap(_ view: SearchAfterLocalView, model: SearchLocal) {
        listener?.didTap(local: model)
    }
    
}

