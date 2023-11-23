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

public protocol StoryDetailRouting: ViewableRouting {
}

protocol StoryDetailPresentable: Presentable {
    var listener: StoryDetailPresentableListener? { get set }
    func setup(model: StoryDetailViewModel)
}

public protocol StoryDetailListener: AnyObject {
    func storyDetailDidTapClose()
}

final class StoryDetailInteractor: PresentableInteractor<StoryDetailPresentable>, StoryDetailInteractable, StoryDetailPresentableListener {

    weak var router: StoryDetailRouting?
    weak var listener: StoryDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StoryDetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: StoryDetailViewModel(userProfileViewModel: SimpleUserProfileViewModel(nickname: "jungmin lim",
                                                                                                     subtitle: "2023.11.23 | 여행",
                                                                                                     profileImageUrl: "https://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg",
                                                                                                     userStatus: .nonFollowing),
                                                    headerViewModel: StoryHeaderViewModel(title: "온반 주문했어요",
                                                                                          badgeId: 0,
                                                                                          likesCount: 3, commentsCount: 4),
                                                    images: ["https://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg",
                                                            "https://public.codesquad.kr/jk/storeapp/data/main/1155_ZIP_P_0081_T.jpg"],
                                                    content: "점심 맛있게 드세요"))
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
                                                                   badgeId: content.badgeId,
                                                                   likesCount: likesCount,
                                                                   commentsCount: commentsCount),
                                    images: content.imageUrls,
                                    content: content.content)
        
    }
}
