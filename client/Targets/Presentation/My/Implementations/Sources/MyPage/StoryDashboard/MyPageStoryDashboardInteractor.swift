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

protocol MyPageStoryDashboardRouting: ViewableRouting {}

protocol MyPageStoryDashboardPresentable: Presentable {
    var listener: MyPageStoryDashboardPresentableListener? { get set }
    func setup(model: MyPageStoryDashboardViewControllerModel)
}

protocol MyPageStoryDashboardListener: AnyObject {
    func storyDashboardDidTapSeeAll()
}

protocol MyPageStoryDashboardInteractorDependency: AnyObject {
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { get }
}

final class MyPageStoryDashboardInteractor: PresentableInteractor<MyPageStoryDashboardPresentable>, MyPageStoryDashboardInteractable, MyPageStoryDashboardPresentableListener {
    
    weak var router: MyPageStoryDashboardRouting?
    weak var listener: MyPageStoryDashboardListener?
    
    private let dependency: MyPageStoryDashboardInteractorDependency
    private var cancellables = Set<AnyCancellable>()
    
    init(
        presenter: MyPageStoryDashboardPresentable,
        dependency: MyPageStoryDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.myPageStoryUseCase
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
        listener?.storyDashboardDidTapSeeAll()
    }
    
}

private extension Array where Element == MyPageStory {
    
    func toModel() -> MyPageStoryDashboardViewControllerModel {
        return MyPageStoryDashboardViewControllerModel(
            contentModels: self.map { .init(
                storyId: $0.storyId,
                thumbnailImageURL: $0.thumbnailImageURL ?? "",
                title: $0.title,
                subtitle: $0.content,
                likes: $0.likeCount,
                comments: 0
            )}
        )
    }
    
}
