//
//  MyPageStoryDashboardInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import ModernRIBs
import BasePresentation
import DomainEntities
import DomainInterfaces

protocol ProfileStoryDashboardRouting: ViewableRouting {
    func setUserProfile(_ username: String)
}

protocol ProfileStoryDashboardPresentable: Presentable {
    var listener: ProfileStoryDashboardPresentableListener? { get set }
    func setup(model: ProfileStoryDashboardViewControllerModel)
}

protocol ProfileStoryDashboardListener: AnyObject {
    func profileStoryDashboardDidTapSeeAll()
    func profileStoryDashboardDidTapStory(storyId: Int)
}

protocol ProfileStoryDashboardInteractorDependency: AnyObject {
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { get }
}

final class ProfileStoryDashboardInteractor: PresentableInteractor<ProfileStoryDashboardPresentable>, ProfileStoryDashboardInteractable, ProfileStoryDashboardPresentableListener {
    
    weak var router: ProfileStoryDashboardRouting?
    weak var listener: ProfileStoryDashboardListener?
    
    private let dependency: ProfileStoryDashboardInteractorDependency
    private var cancellables = Set<AnyCancellable>()
    
    init(
        presenter: ProfileStoryDashboardPresentable,
        dependency: ProfileStoryDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.profileStoryDashboardUseCase
            .storyListPubliser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stories in
                self?.presenter.setup(model: stories.toModel())
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        listener?.profileStoryDashboardDidTapSeeAll()
    }
    
    func didTapStory(id: Int) {
        listener?.profileStoryDashboardDidTapStory(storyId: id)
    }
    
}

private extension Array where Element == MyPageStory {
    
    func toModel() -> ProfileStoryDashboardViewControllerModel {
        return ProfileStoryDashboardViewControllerModel(
            contentModels: self.map { .init(
                storyId: $0.storyId,
                thumbnailImageURL: $0.thumbnailImageURL ?? "",
                title: $0.title,
                subtitle: $0.content,
                likes: $0.likeCount,
                comments: $0.commentCount
            )}
        )
    }
    
}
