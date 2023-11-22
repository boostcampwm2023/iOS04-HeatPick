//
//  HomeFriendDashboardViewController.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit
import BasePresentation

struct HomeFriendDashboardViewModel {
    let contentList: [HomeFriendContentViewModel]
}

protocol HomeFriendDashboardPresentableListener: AnyObject {}

final class HomeFriendDashboardViewController: UIViewController, HomeFriendDashboardPresentable, HomeFriendDashboardViewControllable {

    weak var listener: HomeFriendDashboardPresentableListener?
    
    private enum Constant {
        static let spacing: CGFloat = 20
        static let contentSpacing: CGFloat = 25
    }
    
    private lazy var titleView: SeeAllView = {
        let titleView = SeeAllView()
        titleView.setup(model: .init(
            title: "친구 추천",
            isButtonEnabled: false
        ))
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setup(model: HomeFriendDashboardViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        model.contentList.forEach { contentModel in
            let contentView = HomeFriendContentView()
            contentView.setup(model: contentModel)
            contentView.layer.cornerRadius = Constants.cornerRadiusMedium
            stackView.addArrangedSubview(contentView)
        }
    }
    
}

private extension HomeFriendDashboardViewController {
    
    func setupViews() {
        view.addSubview(titleView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            scrollView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constant.spacing),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
}
