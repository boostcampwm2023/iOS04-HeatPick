//
//  HomeFollowingDashboardViewController.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit
import BasePresentation

struct HomeFollowingDashboardViewModel {
    let contentList: [HomeFollowingContentViewModel]
}

protocol HomeFollowingDashboardPresentableListener: AnyObject {
    func didTapSeeAll()
    func didTap(storyId: Int)
    func didAppear()
}

final class HomeFollowingDashboardViewController: UIViewController, HomeFollowingDashboardPresentable, HomeFollowingDashboardViewControllable {

    weak var listener: HomeFollowingDashboardPresentableListener?
    
    private enum Constant {
        static let title = "팔로잉"
        static let contentSpacing: CGFloat = 20
        static let emptyViewHeight: CGFloat = 80
    }
    
    private var scrollViewBottomConstraint: NSLayoutConstraint?
    private var emptyViewBottomConstraint: NSLayoutConstraint?
    
    private lazy var titleView: SeeAllView = {
        let titleView = SeeAllView()
        titleView.setup(model: .init(
            title: Constant.title,
            isButtonEnabled: false
        ))
        titleView.delegate = self
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private let emptyView: HomeEmptyView = {
        let emptyView = HomeEmptyView()
        emptyView.setup(model: .init(
            title: "팔로잉이 없어요",
            subtitle: "새로운 친구를 추가해보세요"
        ))
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = true
        scrollView.contentInset = .zero
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = Constant.contentSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.didAppear()
    }
    
    func setup(model: HomeFollowingDashboardViewModel) {
        let isEmpty = model.contentList.isEmpty
        titleView.setup(model: .init(
            title: Constant.title,
            isButtonEnabled: !isEmpty
        ))
        
        emptyView.isHidden = !isEmpty
        emptyViewBottomConstraint?.isActive = isEmpty
        
        scrollView.isHidden = isEmpty
        scrollViewBottomConstraint?.isActive = !isEmpty
        
        model.contentList.forEach { contentModel in
            let contentView = HomeFollowingContentView()
            contentView.delegate = self
            contentView.setup(model: contentModel)
            stackView.addArrangedSubview(contentView)
        }
    }
    
}

extension HomeFollowingDashboardViewController: SeeAllViewDelegate {
    
    func seeAllViewDidTapSeeAll() {
        listener?.didTapSeeAll()
    }
    
}

extension HomeFollowingDashboardViewController: HomeFollowingContentViewDelegate {
    
    func homeFollowingContentViewDidTap(_ view: HomeFollowingContentView, storyId: Int) {
        listener?.didTap(storyId: storyId)
    }
    
}

private extension HomeFollowingDashboardViewController {
    
    func setupViews() {
        view.addSubview(titleView)
        view.addSubview(emptyView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        scrollViewBottomConstraint?.isActive = true
        
        emptyViewBottomConstraint = emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        emptyViewBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constant.contentSpacing),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.heightAnchor.constraint(equalToConstant: Constant.emptyViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constant.contentSpacing),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
}
