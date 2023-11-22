//
//  MyPageInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces

protocol MyPageRouting: ViewableRouting {
    func attachUserDashboard()
    func detachUserDashboard()
    func attachStoryDashboard()
    func detachStoryDashboard()
    func attachStorySeeAll()
    func detachStorySeeAll()
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener {
    
    weak var router: MyPageRouting?
    weak var listener: MyPageListener?
    
    override init(presenter: MyPagePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachUserDashboard()
        router?.attachStoryDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSetting() {
        print("# Setting 화면으로 이동")
    }
    
    // MARK: - UserDashboard
    
    func userDashboardDidTapProfile() {
        print("# 프로필 변경으로 이동")
    }
    
    // MARK: - StoryDashboard
    
    func storyDashboardDidTapSeeAll() {
        router?.attachStorySeeAll()
    }
    
    // MARK: - StorySeeAll
    
    func myPageStorySeeAllDidTapClose() {
        router?.detachStorySeeAll()
    }
    
}
