//
//  MyPageStoryDashboardInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol MyPageStoryDashboardRouting: ViewableRouting {}

protocol MyPageStoryDashboardPresentable: Presentable {
    var listener: MyPageStoryDashboardPresentableListener? { get set }
    func setup(model: MyPageStoryDashboardViewControllerModel)
}

protocol MyPageStoryDashboardListener: AnyObject {
    func storyDashboardDidTapSeeAll()
}

final class MyPageStoryDashboardInteractor: PresentableInteractor<MyPageStoryDashboardPresentable>, MyPageStoryDashboardInteractable, MyPageStoryDashboardPresentableListener {
    
    weak var router: MyPageStoryDashboardRouting?
    weak var listener: MyPageStoryDashboardListener?
    
    override init(presenter: MyPageStoryDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(contentModels: [
            .init(thumbnailImageURL: "https://avatars.githubusercontent.com/u/74225754?v=4", title: "title 123", subtitle: "subtitle 123123123123", likes: 0, comments: 10000),
            .init(thumbnailImageURL: "https://avatars.githubusercontent.com/u/74225754?v=4", title: "title 123", subtitle: "subtitle 123123123123", likes: 1231230, comments: 1231230),
            .init(thumbnailImageURL: "https://avatars.githubusercontent.com/u/74225754?v=4", title: "title 123", subtitle: "subtitle 123123123123", likes: 1231231230, comments: 0),
        ]))
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        listener?.storyDashboardDidTapSeeAll()
    }
    
}
