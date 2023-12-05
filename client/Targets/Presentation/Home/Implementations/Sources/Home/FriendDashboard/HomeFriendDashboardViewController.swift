//
//  HomeFriendDashboardViewController.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import CoreKit
import DesignKit
import BasePresentation

struct HomeFriendDashboardViewModel {
    let contentList: [HomeFriendContentViewModel]
}

protocol HomeFriendDashboardPresentableListener: AnyObject {}

final class HomeFriendDashboardViewController: BaseViewController, HomeFriendDashboardPresentable, HomeFriendDashboardViewControllable {

    weak var listener: HomeFriendDashboardPresentableListener?
    
    private enum Constant {
        static let spacing: CGFloat = 20
        static let contentSpacing: CGFloat = 25
    }
    
    private let titleView = SeeAllView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    func setup(model: HomeFriendDashboardViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        model.contentList.forEach { contentModel in
            let contentView = HomeFriendContentView()
            contentView.setup(model: contentModel)
            contentView.layer.cornerRadius = Constants.cornerRadiusMedium
            stackView.addArrangedSubview(contentView)
        }
    }
    
    override func setupLayout() {
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
    
    override func setupAttributes() {
        titleView.do {
            $0.setup(model: .init(
                title: "친구 추천",
                isButtonEnabled: false
            ))
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentInset = .init(top: 0, left: Constant.spacing, bottom: 0, right: Constant.spacing)
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = Constant.contentSpacing
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        
    }
    
}
