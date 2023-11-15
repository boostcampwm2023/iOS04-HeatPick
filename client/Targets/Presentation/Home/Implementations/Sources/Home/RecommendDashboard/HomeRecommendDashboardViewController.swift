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

protocol HomeRecommendDashboardPresentableListener: AnyObject {}

final class HomeRecommendDashboardViewController: UIViewController, HomeRecommendDashboardPresentable, HomeRecommendDashboardViewControllable {
    
    weak var listener: HomeRecommendDashboardPresentableListener?
    
    private let titleView: HomeTitleView = {
        let titleView = HomeTitleView()
        titleView.setup(model: .init(
            title: "강남구 추천 장소", 
            isButtonEnabled: false
        ))
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private let emptyView: HomeEmptyView = {
        let emptyView = HomeEmptyView()
        emptyView.setup(model: .init(
            title: "추천 장소가 없어요",
            subtitle: "스토리를 작성하시면 추천 장소가 될 수 있어요"
        ))
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension HomeRecommendDashboardViewController {
    
    func setupViews() {
        view.addSubview(titleView)
        view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            emptyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
