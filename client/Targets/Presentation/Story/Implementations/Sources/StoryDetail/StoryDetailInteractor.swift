//
//  StoryDetailInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import DomainEntities
import DomainInterfaces

public protocol StoryDetailRouting: ViewableRouting {
}

protocol StoryDetailPresentable: Presentable {
    var listener: StoryDetailPresentableListener? { get set }
    func setup(model: StoryDetailViewModel)
    func showFailure(_ error: Error)
}

public protocol StoryDetailListener: AnyObject {
    func storyDetailDidTapClose()
}

protocol StoryDetailInteractorDependency: AnyObject {
    var storyId: Int { get }
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryDetailInteractor: PresentableInteractor<StoryDetailPresentable>, StoryDetailInteractable, StoryDetailPresentableListener {

    weak var router: StoryDetailRouting?
    weak var listener: StoryDetailListener?
    private var dependency: StoryDetailInteractorDependency

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
                .requestStoryDetail(story: dependency.storyId)
                .onSuccess(on: .main, with: self) { this, story in
                    guard let model = story.toViewModel() else { return }
                    this.presenter.setup(model: model)
                }
                .onFailure(on: .main, with: self) { this, error in
                    print(error.localizedDescription)
                    this.presenter.showFailure(error)
                }
            
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func storyDetailDidTapClose() {
        listener?.storyDetailDidTapClose()
    }
}

fileprivate extension Story {
    func toViewModel() -> StoryDetailViewModel? {
        guard let content, let author else { return nil }
        let dateFormat: Date.FormatStyle = Date.FormatStyle()
                                                        .year(.defaultDigits)
                                                        .month(.abbreviated)
                                                        .day(.twoDigits)
        
        return StoryDetailViewModel(userProfileViewModel: SimpleUserProfileViewModel(nickname: author.nickname,
                                                                              subtitle: "\(content.date.formatted(dateFormat)) | \(content.category)",
                                                                              profileImageUrl: author.profileImageUrl,
                                                                              userStatus: author.authorStatus),
                                    headerViewModel: StoryHeaderViewModel(title: content.title,
                                                                   badgeName: content.badgeName,
                                                                   likesCount: likesCount,
                                                                   commentsCount: commentsCount),
                                    images: content.imageUrls,
                                    content: content.content,
                                    storyMapViewModel: StoryMapViewModel(latitude: CGFloat(content.place.lat),
                                                                         longitude: CGFloat(content.place.lng),
                                                                         address: content.place.address))
        
    }
}
