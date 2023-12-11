//
//  UserProfileInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import MyInterfaces
import DomainEntities
import DomainInterfaces

protocol UserProfileRouting: ProfileRouting {
    func setUserProfile(_ username: String)
}

protocol UserProfilePresentable: Presentable {
    var userProfileListener: UserProfilePresentableListener? { get set }
}

protocol UserProfileInteractorDependency: AnyObject {
    var userId: Int { get }
    var userProfileUseCase: UserProfileUseCaseInterface { get }
}

final class UserProfileInteractor: PresentableInteractor<UserProfilePresentable>, UserProfilePresentableListener, UserProfileInteractable {
    
    weak var router: UserProfileRouting?
    weak var listener: UserProfileListener?
    
    private let dependency: UserProfileInteractorDependency
    private let cancelBag = CancelBag()
    private var myPage: Profile?
    
    init(
        presenter: UserProfilePresentable,
        dependency: UserProfileInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.userProfileListener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachUserDashboard()
        router?.attachStoryDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func viewWillAppear() {
        fetchProfile()
    }
    
    func didTapBack() {
        listener?.detachUserProfile()
    }
    
    func storyDashboardDidTapSeeAll() {
        guard let myPage else { return }
        router?.attachStorySeeAll(userId: myPage.userId)
    }
    
    func storyDashboardDidTapStory(id: Int) {
        router?.attachStoryDetail(id: id)
    }
    
    func myPageStorySeeAllDidTapClose() {
        router?.detachStorySeeAll()
    }
    
    func myPageStorySeeAllDidTapStory(id: Int) {
        router?.attachStoryDetail(id: id)
    }
    
    func fetchProfile() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.userProfileUseCase
                .fetchUserProfile(userId: dependency.userId)
                .onSuccess(on: .main, with: self) { this, myPage in
                    this.myPage = myPage
                    this.router?.setUserProfile(myPage.userName)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }

    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
    }
    
    func storyDidDelete() {
        router?.detachStoryDetail()
    }
        
}
