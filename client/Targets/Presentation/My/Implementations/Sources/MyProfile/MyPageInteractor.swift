//
//  MyPageInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
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
    func attachStoryDetail(storyId: Int)
    func detachStoryDetail()
    func attachSetting()
    func detachSetting()
    func attachupdateUserDashboard()
    func detachUpdateUserDashboard()
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
    
    func setupNavigation(_ username: String)
}

final class MyPageInteractor: PresentableInteractor<MyPagePresentable>, MyPageInteractable, MyPagePresentableListener {
    
    
    weak var router: MyPageRouting?
    weak var listener: MyPageListener?
    
    private let dependency: MyPageInteractorDependency
    private let cancelBag = CancelBag()
    private var profile: Profile?
    
    init(
        presenter: MyPagePresentable,
        depedency: MyPageInteractorDependency
    ) {
        self.dependency = depedency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachUserDashboard()
        router?.attachStoryDashboard()
        fetchProfile()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func viewWillAppear() {
        fetchProfile()
    }
    
    func didTapSetting() {
        router?.attachSetting()
    }
    
    // MARK: - MyPageUpdateUser
    
    func profileEditButtonDidTap() {
        router?.attachupdateUserDashboard()
    }
    
    func detachMyPageUpdateUserDasbaord() {
        router?.detachUpdateUserDashboard()
    }
    
    // MARK: - StoryDashboard
    func profileStoryDashboardDidTapSeeAll() {
        guard let profile else { return }
        router?.attachStorySeeAll(userId: profile.userId)
    }
    
    func profileStoryDashboardDidTapStory(storyId: Int) {
        router?.attachStoryDetail(storyId: storyId)
    }

    
    // MARK: - StorySeeAll
    func profileStoryDashboardSeeAllDidTapClose() {
        router?.detachStorySeeAll()
    }
    
    func profileStoryDashboardSeeAllDidTapStory(storyId: Int) {
        router?.attachStoryDetail(storyId: storyId)
    }

    // MARK: - Setting
    
    func settingDidTapClose() {
        router?.detachSetting()
    }
    
    private func fetchProfile() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.myPageUseCase
                .fetchMyProfile()
                .onSuccess(on: .main, with: self) { this, profile in
                    this.profile = profile
                    this.presenter.setupNavigation(profile.userName)
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
    
    func storyDidDelete() {
        router?.detachStoryDetail()
    }
    
}
