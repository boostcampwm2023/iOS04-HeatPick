//
//  StoryDetailInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces
import StoryInterfaces

protocol StoryDetailRouting: ViewableRouting {
    func attachComment(storyId: Int)
    func detachComment()
}

protocol StoryDetailPresentable: Presentable {
    var listener: StoryDetailPresentableListener? { get set }
    func setup(model: StoryDetailViewModel)
    func didFollow()
    func didUnfollow()
    func showFailure(_ error: Error)
}

protocol StoryDetailInteractorDependency: AnyObject {
    var storyId: Int { get }
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryDetailInteractor: PresentableInteractor<StoryDetailPresentable>,
                                   StoryDetailInteractable,
                                   StoryDetailPresentableListener {

    weak var router: StoryDetailRouting?
    weak var listener: StoryDetailListener?
    private let dependency: StoryDetailInteractorDependency
    
    private var cancelBag: CancelBag = CancelBag()
    
    init(presenter: StoryDetailPresentable, dependency: StoryDetailInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        Task { [weak self] in
            guard let self else { return }
            await dependency
                .storyUseCase
                .requestStoryDetail(storyId: dependency.storyId)
                .onSuccess(on: .main, with: self) { this, story in
                    guard let model = story.toViewModel() else { return }
                    this.presenter.setup(model: model)
                }
                .onFailure(on: .main, with: self) { this, error in
                    print(error.localizedDescription)
                    this.presenter.showFailure(error)
                }
        }.store(in: cancelBag)
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func storyDetailDidTapClose() {
        listener?.storyDetailDidTapClose()
    }
    
    func followButtonDidTap(userId: Int, userStatus: UserStatus) {
        switch userStatus {
        case .me: 
            return
        case .nonFollowing:
            requestFollow(userId)
        case .following:
            requestUnfollow(userId)
        }
    }
    
    func commentButtonDidTap() {
        router?.attachComment(storyId: dependency.storyId)
    }
    
    func commentDidTapClose() {
        router?.detachComment()
    }
    
}

private extension StoryDetailInteractor {
    
    func requestFollow(_ userId: Int) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestFollow(userId: userId)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.presenter.didFollow()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to follow \(userId) with \(error.localizedDescription)", log: .interactor)
                    this.presenter.didUnfollow()
                }
        }.store(in: cancelBag)
    }
    
    func requestUnfollow(_ userId: Int) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestUnfollow(userId: userId)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.presenter.didUnfollow()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to unfollow \(userId) with \(error.localizedDescription)", log: .interactor)
                    this.presenter.didFollow()
                }
        }.store(in: cancelBag)
    }
}

fileprivate extension Story {
    func toViewModel() -> StoryDetailViewModel? {
        guard let content, let author else { return nil }
        let dateFormat: Date.FormatStyle = Date.FormatStyle()
                                                        .year(.defaultDigits)
                                                        .month(.abbreviated)
                                                        .day(.twoDigits)
        
        return StoryDetailViewModel(userProfileViewModel: SimpleUserProfileViewModel(id: author.id,
                                                                                     nickname: author.nickname,
                                                                                     subtitle: "\(content.date.formatted(dateFormat)) | \(content.category.title)",
                                                                                     profileImageUrl: author.profileImageUrl,
                                                                                     userStatus: author.authorStatus),
                                    headerViewModel: StoryHeaderViewModel(title: content.title,
                                                                          badgeName: content.badge.title,
                                                                          likesCount: likesCount,
                                                                          commentsCount: commentsCount),
                                    images: content.imageUrls,
                                    content: content.content,
                                    storyMapViewModel: StoryMapViewModel(latitude: content.place.lat,
                                                                         longitude: content.place.lng,
                                                                         address: content.place.address))
        
    }
}
