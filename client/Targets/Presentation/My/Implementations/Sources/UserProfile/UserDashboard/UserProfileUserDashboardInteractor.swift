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

protocol UserProfileUserDashboardRouting: ViewableRouting {
    func setUserProfile()
}

protocol UserProfileUserDashboardPresentable: ProfileUserDashboardPresentable {
    var userProfileListener: UserProfileUserDashboardPresentableListener? { get set }
}

protocol UserProfileUserDashboardListener: AnyObject {
    func followButtonDidTap()
}

protocol UserProfileUserDashboardInteractorDependency: AnyObject {
    var userProfileUserUseCase: MyPageProfileUseCaseInterface { get }
}

final class UserProfileUserDashboardInteractor: PresentableInteractor<UserProfileUserDashboardPresentable>, UserProfileUserDashboardInteractable, UserProfileUserDashboardPresentableListener {
    
    weak var router: UserProfileUserDashboardRouting?
    weak var listener: UserProfileUserDashboardListener?

    private let dependency: UserProfileUserDashboardInteractorDependency
    private var cancellables = Set<AnyCancellable>()
    
    init(
        presenter: UserProfileUserDashboardPresentable,
        dependency: UserProfileUserDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.userProfileListener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.userProfileUserUseCase
            .profilePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                self?.presenter.setup(model: profile.toModel())
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    
    // TODO: follow 로직
    func followButtonDidTap() {
        
    }
    
}

private extension MyPageProfile {
    
    func toModel() -> MyPageUserDashboardViewControllerModel {
        return .init(
            userName: userName,
            profileImageURL: profileImageURL,
            follower: "\(followerCount)", // 팔로잉 변환 로직 추가
            storyCount: "\(storyCount)",
            experience: "\((experience * 100) / maxExperience)%",
            temperatureTitle: temperatureFeeling,
            temperature: "\(temperature)℃",
            badgeTitle: mainBadge.emoji + " " + mainBadge.name,
            badgeContent: mainBadge.description
        )
    }
    
}
