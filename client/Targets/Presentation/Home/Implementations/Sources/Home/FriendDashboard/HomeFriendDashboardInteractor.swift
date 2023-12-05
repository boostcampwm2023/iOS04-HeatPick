//
//  HomeFriendDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces

protocol HomeFriendDashboardRouting: ViewableRouting {}

protocol HomeFriendDashboardPresentable: Presentable {
    var listener: HomeFriendDashboardPresentableListener? { get set }
    func setup(model: HomeFriendDashboardViewModel)
}

protocol HomeFriendDashboardListener: AnyObject {
    func homeFriendDashboardEmptyFriend()
    func homeFriendDashbardDidTapUser(_ userId: Int)
}

protocol HomeFriendDashboardInteractorDependency: AnyObject {
    var userRecommendUseCase: UserRecommendUseCaseInterface { get }
}

final class HomeFriendDashboardInteractor: PresentableInteractor<HomeFriendDashboardPresentable>, HomeFriendDashboardInteractable, HomeFriendDashboardPresentableListener {
    
    weak var router: HomeFriendDashboardRouting?
    weak var listener: HomeFriendDashboardListener?
    
    private let dependency: HomeFriendDashboardInteractorDependency
    private let cancelBag = CancelBag()
    
    init(
        presenter: HomeFriendDashboardPresentable,
        dependency: HomeFriendDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchUserRecommend()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapUserProfile(userId: Int) {
        listener?.homeFriendDashbardDidTapUser(userId)
    }
    
    private func fetchUserRecommend() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.userRecommendUseCase.fetchUserRecommend()
                .onSuccess(on: .main, with: self) { this, recommends in
                    this.performAfterFetchingUserRecommend(recommends)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }
    
    private func performAfterFetchingUserRecommend(_ recommends: [UserRecommend]) {
        if recommends.isEmpty {
            listener?.homeFriendDashboardEmptyFriend()
            return
        }
        let model = HomeFriendDashboardViewModel(
            contentList: recommends.map { .init(userId: $0.userId, nickname: $0.username, profileImageURL: $0.profileUrl) }
        )
        presenter.setup(model: model)
    }
    
}
