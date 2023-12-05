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

protocol MyPageUserDashboardRouting: ViewableRouting {}

protocol MyPageUserDashboardPresentable: Presentable {
    var listener: MyPageUserDashboardPresentableListener? { get set }
    func setup(model: MyPageUserDashboardViewControllerModel)
}

protocol MyPageUserDashboardListener: AnyObject {
    func profileEidtButtonDidTap()
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
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.myPageProfileUseCase
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
    
    func profileEidtButtonDidTap() {
        listener?.profileEidtButtonDidTap()
    }
    
    // TODO: 팔로우 로직
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
