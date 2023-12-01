//
//  SearchAfterStoryDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol SearchAfterStoryDashboardRouting: ViewableRouting { }

protocol SearchAfterStoryDashboardPresentable: Presentable {
    var listener: SearchAfterStoryDashboardPresentableListener? { get set }
    func setup(models: [SearchStory])
}

protocol SearchAfterStoryDashboardListener: AnyObject {
    var searchResultStoriesPublisher: AnyPublisher<[SearchStory], Never> { get }
    
    func searchStorySeeAllDidTap()
    func didTapStory(storyId: Int)
}

final class SearchAfterStoryDashboardInteractor: PresentableInteractor<SearchAfterStoryDashboardPresentable>, SearchAfterStoryDashboardInteractable, SearchAfterStoryDashboardPresentableListener {
    
    weak var router: SearchAfterStoryDashboardRouting?
    weak var listener: SearchAfterStoryDashboardListener?
    
    private var cancellables: Set<AnyCancellable> = []
    
    override init(presenter: SearchAfterStoryDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        listener?.searchResultStoriesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stories in
                self?.presenter.setup(models: stories)
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func searchStorySeeAllDidTap() {
        listener?.searchStorySeeAllDidTap()
    }
    
    func didTapStory(storyId: Int) {
        listener?.didTapStory(storyId: storyId)
    }
    
}
