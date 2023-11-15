//
//  HomeInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeRouting: ViewableRouting {
    func attachRecommendDashboard()
    func attachHotPlaceDashboard()
    func attachFollowingDashboard()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
    func setDashboard(_ viewControllable: ViewControllable)
}

public protocol HomeListener: AnyObject {}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {

    weak var router: HomeRouting?
    weak var listener: HomeListener?

    override init(presenter: HomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachRecommendDashboard()
        router?.attachHotPlaceDashboard()
        router?.attachFollowingDashboard()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - Recommend
    
    func recommendDashboardDidTapSeeAll() {
        print("# Attach Recommend See All View")
    }
    
    // MARK: - HotPlace
    
    func hotPlaceDashboardDidTapSeeAll() {
        print("# Attach HotPlace See All View")
    }
    
    // MARK: - Following
    
    func followingDashboardDidTapSeeAll() {
        print("# Attach Following See All View")
    }
    
}
