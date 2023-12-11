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

protocol UserProfileRouting: ViewableRouting {
    func attachUserDashboard()
    func detachUserDashboard()
    func attachStoryDashboard()
    func detachStoryDashboard()
    func attachStorySeeAll(userId: Int)
    func detachStorySeeAll()
    func attachStoryDetail(storyId: Int)
    func detachStoryDetail()
}

protocol UserProfilePresentable: Presentable {
    var listener: UserProfilePresentableListener? { get set }
    
    func setupNavi(_ username: String)
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
    private var profile: Profile?
    
    init(
        presenter: UserProfilePresentable,
        dependency: UserProfileInteractorDependency
    ) {
        self.dependency = dependency
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
        cancelBag.cancel()
    }
    
    func viewWillAppear() {
        fetchProfile()
    }
    
    func didTapBack() {
        listener?.detachUserProfile()
    }
    
    func profileStoryDashboardDidTapSeeAll() {
        guard let profile else { return }
        router?.attachStorySeeAll(userId: profile.userId)
    }
    
    func profileStoryDashboardDidTapStory(storyId: Int) {
        router?.attachStoryDetail(storyId: storyId)
    }
    
    func profileStoryDashboardSeeAllDidTapClose() {
        router?.detachStorySeeAll()
    }

    func profileStoryDashboardSeeAllDidTapStory(storyId: Int) {
        router?.attachStoryDetail(storyId: storyId)
    }
    
    func fetchProfile() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.userProfileUseCase
                .fetchUserProfile(userId: dependency.userId)
                .onSuccess(on: .main, with: self) { this, profile in
                    this.profile = profile
                    this.presenter.setupNavi(profile.userName)
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
