//
//  HomeRecommendDashboardViewController.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit
import BasePresentation

struct HomeRecommendDashboardViewModel {
    let title: String
    let contentList: [HomeRecommendContentViewModel]
}

protocol HomeRecommendDashboardPresentableListener: AnyObject {
    func didTapSeeAll()
    func didTap(storyId: Int)
    func didAppear()
}

final class HomeRecommendDashboardViewController: UIViewController, HomeRecommendDashboardPresentable, HomeRecommendDashboardViewControllable {
    
    weak var listener: HomeRecommendDashboardPresentableListener?
    
    private enum Constant {
        static let emptyTitle = "추천 장소가 없어요"
        static let emptySubtitle = "스토리를 작성하시면 추천 장소가 될 수 있어요"
        static let spacing: CGFloat = 20
        static let contentSpacing: CGFloat = 10
        static let emptyViewHeight: CGFloat = 80
    }
    
    private var scrollViewBottomConstraint: NSLayoutConstraint?
    private var emptyViewBottomConstraint: NSLayoutConstraint?
    
    private lazy var titleView: SeeAllView = {
        let titleView = SeeAllView()
        titleView.setup(model: .init(
            title: "추천 장소",
            isButtonEnabled: false
        ))
        titleView.delegate = self
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private let emptyView: HomeEmptyView = {
        let emptyView = HomeEmptyView()
        emptyView.setup(model: .init(
            title: Constant.emptyTitle,
            subtitle: Constant.emptySubtitle
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
        scrollView.contentInset = .init(top: 0, left: Constant.spacing, bottom: 0, right: Constant.spacing)
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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
    
    func setup(model: HomeRecommendDashboardViewModel) {
        let isEmpty = model.contentList.isEmpty
        titleView.setup(model: .init(title: model.title, isButtonEnabled: !isEmpty))
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        emptyView.isHidden = !isEmpty
        emptyViewBottomConstraint?.isActive = isEmpty
        
        scrollView.isHidden = isEmpty
        scrollViewBottomConstraint?.isActive = !isEmpty
        
        model.contentList.forEach { contentModel in
            let contentView = HomeRecommendContentView()
            contentView.addTapGesture(target: self, action: #selector(contentViewDidTap))
            contentView.clipsToBounds = true
            contentView.setup(model: contentModel)
            contentView.layer.cornerRadius = Constants.cornerRadiusMedium
            stackView.addArrangedSubview(contentView)
        }
    }
    
}

extension HomeRecommendDashboardViewController: SeeAllViewDelegate {
    
    func seeAllViewDidTapSeeAll() {
        listener?.didTapSeeAll()
    }
    
}

private extension HomeRecommendDashboardViewController {
    
    @objc func contentViewDidTap(_ gesture: UITapGestureRecognizer) {
        guard let contentView = gesture.view as? HomeRecommendContentView,
              let storyId = contentView.id else {
            return
        }
        listener?.didTap(storyId: storyId)
    }
    
}

private extension HomeRecommendDashboardViewController {
    
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
            
            emptyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constant.spacing),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.heightAnchor.constraint(equalToConstant: Constant.emptyViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constant.spacing),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
}
