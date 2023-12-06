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
    func attachupdateUserDashboard()
    func detachUpdateUserDashboard() 
    func setMyProfile(_ username: String)
    func setUserProfile(_ username: String)
}

protocol MyPagePresentable: Presentable {
    var listener: MyPagePresentableListener? { get set }
}

protocol MyPageInteractorDependency: AnyObject {
    var userId: Int? { get }
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
        fetchProfile()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSetting() {
        router?.attachSetting()
    }
    
    func didTapBack() {
        listener?.detachMyPage()
    }
    
    // MARK: - UserDashboard
    
    func profileEditButtonDidTap() {
        router?.attachupdateUserDashboard()
    }
    
    func detachMyPageUpdateUserDasbaord() {
        router?.detachUpdateUserDashboard()
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
    
    private func fetchProfile() {
        Task { [weak self] in
            guard let self else { return }
            if let userId = depedency.userId {
                await depedency.myPageUseCase
                    .fetchProfile(userId: userId)
                    .onSuccess(on: .main, with: self) { this, myPage in
                        this.myPage = myPage
                        this.router?.setUserProfile(myPage.userName)
                    }
                    .onFailure { error in
                        Log.make(message: error.localizedDescription, log: .interactor)
                    }
            } else {
                await depedency.myPageUseCase
                    .fetchMyProfile()
                    .onSuccess(on: .main, with: self) { this, myPage in
                        this.myPage = myPage
                        this.router?.setMyProfile(myPage.userName)
                    }
                    .onFailure { error in
                        Log.make(message: error.localizedDescription, log: .interactor)
                    }
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
    
    // MARK: UpdateUser
    func updateUser(model: UserUpdateContent) {
        Task { [weak self] in
            guard let self else { return }
            await depedency.myPageUseCase.fetchUserInfo(userUpdate: model)
                .onSuccess { _ in
                    self.fetchProfile()
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .network)
                }
        }.store(in: cancelBag)
    }

}
