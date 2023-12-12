//
//  UserProfileUserDashboardInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol UserProfileUserDashboardRouting: ViewableRouting { }

protocol UserProfileUserDashboardPresentable: Presentable {
    var listener: UserProfileUserDashboardPresentableListener? { get set }
    
    func setup(model: UserProfileViewControllerModel)
    func updateFollow(_ isFollow: Bool)
}

protocol UserProfileUserDashboardListener: AnyObject  {
    func fetchProfile()
}

protocol UserProfileUserDashboardInteractorDependency: AnyObject {
    var profileUserDashboardUseCaseInterface: ProfileUserDashboardUseCaseInterface { get }
}

final class UserProfileUserDashboardInteractor: PresentableInteractor<UserProfileUserDashboardPresentable>, UserProfileUserDashboardInteractable, UserProfileUserDashboardPresentableListener {
    
    weak var router: UserProfileUserDashboardRouting?
    weak var listener: UserProfileUserDashboardListener?

    private let dependency: UserProfileUserDashboardInteractorDependency
    private var cancellables = Set<AnyCancellable>()
    private var cancelBag = CancelBag()
    
    private var userId: Int?
    private var isFollow: Bool = false
    
    init(
        presenter: UserProfileUserDashboardPresentable,
        dependency: UserProfileUserDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.profileUserDashboardUseCaseInterface
            .profilePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                guard let self else { return }
                self.presenter.setup(model: UserProfile(profile: profile).toModel())
                self.userId = profile.userId
                self.isFollow = profile.isFollow
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func followButtonDidTap() {
        isFollow ? unfollow() : follow()
    }
    
}

private extension UserProfileUserDashboardInteractor {
    
    private func follow() {
        Task { [weak self] in
            guard let self,
                  let userId else { return }
            await dependency.profileUserDashboardUseCaseInterface
                .requestFollow(userId: userId)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.isFollow = true
                    this.presenter.updateFollow(this.isFollow)
                    this.listener?.fetchProfile()
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }
    
    private func unfollow() {
        Task { [weak self] in
            guard let self,
                  let userId else { return }
            await dependency.profileUserDashboardUseCaseInterface
                .requestUnfollow(userId: userId)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.isFollow = false
                    this.presenter.updateFollow(this.isFollow)
                    this.listener?.fetchProfile()
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }
    
}

private extension UserProfile {
    
    func toModel() -> UserProfileViewControllerModel {
        return .init(
            userName: userName,
            profileImageURL: profileImageURL,
            isFollow: isFollow,
            follower: "\(followerCount)",
            storyCount: "\(storyCount)",
            experience: "\((experience * 100) / maxExperience)%",
            temperatureTitle: temperatureFeeling,
            temperature: String(format: "%g℃", temperature),
            badgeTitle: mainBadge.emoji + " " + mainBadge.name,
            badgeContent: mainBadge.description
        )
    }
    
}
