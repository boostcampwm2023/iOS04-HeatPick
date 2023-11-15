//
//  HomeHotPlaceDashboardViewController.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

protocol HomeHotPlaceDashboardPresentableListener: AnyObject {}

final class HomeHotPlaceDashboardViewController: UIViewController, HomeHotPlaceDashboardPresentable, HomeHotPlaceDashboardViewControllable {
    
    weak var listener: HomeHotPlaceDashboardPresentableListener?
    
    private let titleView: HomeTitleView = {
        let titleView = HomeTitleView()
        titleView.setup(model: .init(
            title: "핫플레이스",
            isButtonEnabled: false
        ))
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private let emptyView: HomeEmptyView = {
        let emptyView = HomeEmptyView()
        emptyView.setup(model: .init(
            title: "핫플레이가 없어요",
            subtitle: "{업데이트 되는 일정}에 업데이트 되어요"
        ))
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}


private extension HomeHotPlaceDashboardViewController {
    
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
