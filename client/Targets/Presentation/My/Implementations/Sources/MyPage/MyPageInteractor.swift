//
//  MyPageInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import CoreKit
import ModernRIBs
import MyInterfaces
import DomainEntities
import DomainInterfaces

protocol MyPageRouting: ViewableRouting {
    func attachUserDashboard()
    func detachUserDashboard()
    func attachStoryDashboard()
    func detachStoryDashboard()
    func attachStorySeeAll(userId: Int)
    func detachStorySeeAll()
    func attachSetting()
    func detachSetting()
    func attachStoryDetail(id: Int)
    func detachStoryDetail()
    func attachUserInfoEditDashboard()
    func detachUserInfoEditDashboard() 
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
}

protocol MyPageInteractorDependency: AnyObject {
    var myPageUseCase: MyPageUseCaseInterface { get }
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener {
    
    weak var router: MyPageRouting?
    weak var listener: MyPageListener?
    
    private let depedency: MyPageInteractorDependency
    private let cancelBag = CancelBag()
    private var myPage: MyPage?
    
    init(
        presenter: MyPagePresentable,
        depedency: MyPageInteractorDependency
    ) {
        self.depedency = depedency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachUserDashboard()
        router?.attachStoryDashboard()
        fetchMyPage()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSetting() {
        router?.attachSetting()
    }
    
    // MARK: - UserDashboard
    
    func userDashboardDidTapProfile() {
        router?.attachUserInfoEditDashboard()
    }
    
    func didTapBackUserInfoEditDashboard() {
        router?.detachUserInfoEditDashboard()
    }
    
    // MARK: - StoryDashboard
    
    func storyDashboardDidTapSeeAll() {
        guard let myPage else { return }
        router?.attachStorySeeAll(userId: myPage.userId)
    }
    
    func storyDashboardDidTapStory(id: Int) {
        router?.attachStoryDetail(id: id)
    }
    
    // MARK: - StorySeeAll
    
    func myPageStorySeeAllDidTapClose() {
        router?.detachStorySeeAll()
    }
    
    func myPageStorySeeAllDidTapStory(id: Int) {
        router?.attachStoryDetail(id: id)
    }
    
    // MARK: - Setting
    
    func settingDidTapClose() {
        router?.detachSetting()
    }
    
    private func fetchMyPage() {
        Task { [weak self] in
            guard let self else { return }
            await depedency.myPageUseCase
                .fetchMyPage()
                .onSuccess(on: .main, with: self) { this, myPage in
                    this.myPage = myPage
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }
    
    // MARK: - StoryDetail
    
    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
    }
    
}
