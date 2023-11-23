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
    func userDashboardDidTapProfile()
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
    
    func didTapProfile() {
        listener?.userDashboardDidTapProfile()
    }
    
}

private extension MyPageProfile {
    
    func toModel() -> MyPageUserDashboardViewControllerModel {
        return .init(
            userName: userName,
            profileImageURL: profileImageURL,
            follower: "\(followerCount)", // 팔로잉 변환 로직 추가
            storyCount: "\(storyCount)",
            experience: "\(experience)/\(maxExperience)", // 경험치 변환 로직 추가
            temperatureTitle: "따뜻해요", // 온도가 필요할 듯
            temperature: "몇도씨", // 온도가 필요할 듯
            badgeTitle: "아직 뱃지 없음",
            badgeContent: "뱃지 주세요"
        )
    }
    
}
