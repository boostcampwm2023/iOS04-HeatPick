//
//  MyPageUserDashboardInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import ModernRIBs
import DomainEntities
import DomainInterfaces

protocol MyPageUserDashboardRouting: ViewableRouting {
    func setMyProfile()
}

protocol MyPageUserDashboardPresentable: Presentable {
    var myProfileListener: MyPageUserDashboardPresentableListener? { get set }
    func setup(model: MyProfileViewControllerModel)
}

protocol MyPageUserDashboardListener: AnyObject {
    func profileEditButtonDidTap()
}

protocol MyPageUserDashboardInteractorDependency: AnyObject {
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { get }
}

final class MyPageUserDashboardInteractor: PresentableInteractor<MyPageUserDashboardPresentable>, MyPageUserDashboardInteractable, MyPageUserDashboardPresentableListener {

    weak var router: MyPageUserDashboardRouting?
    weak var listener: MyPageUserDashboardListener?
    
    private let dependency: MyPageUserDashboardInteractorDependency
    private var cancellables = Set<AnyCancellable>()

    init(
        presenter: MyPageUserDashboardPresentable,
        dependency: MyPageUserDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.myProfileListener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.myPageProfileUseCase
            .profilePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                self?.presenter.setup(model: MyProfile(profile: profile).toModel())
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func profileEditButtonDidTap() {
        listener?.profileEditButtonDidTap()
    }
    
}

private extension MyProfile {
    
    func toModel() -> MyProfileViewControllerModel {
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
