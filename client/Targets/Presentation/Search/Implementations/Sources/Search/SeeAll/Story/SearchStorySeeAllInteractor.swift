//
//  SearchStorySeeAllInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import BasePresentation
import DomainInterfaces

protocol SearchStorySeeAllRouting: ViewableRouting { }

typealias SearchStorySeeAllPresentable = StorySeeAllPresentable
typealias SearchStroySeeAllPresentableListener = StorySeeAllPresentableListener

protocol SearchStorySeeAllListener: AnyObject {
    func searchStorySeeAllDidTapClose()
    func searchStorySeeAllDidTap(storyId: Int)
}

protocol SearchStorySeeAllInteractorDependency: AnyObject {
    var searchText: String { get }
    var searchStorySeeAllUseCase: SearchStorySeeAllUseCaseInterface { get }
}

final class SearchStorySeeAllInteractor: PresentableInteractor<SearchStorySeeAllPresentable>, SearchStorySeeAllInteractable, SearchStroySeeAllPresentableListener {
    
    weak var router: SearchStorySeeAllRouting?
    weak var listener: SearchStorySeeAllListener?
    
    private let dependency: SearchStorySeeAllInteractorDependency
    
    private var cancelTaskBag: CancelBag = .init()
    
    init(
        presenter: SearchStorySeeAllPresentable,
        dependency: SearchStorySeeAllInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("스토리 검색")
        Task { [weak self] in
            guard let self else { return }
            await self.dependency.searchStorySeeAllUseCase
                .fetchStory(searchText: self.dependency.searchText)
                .onSuccess(on: .main, with: self) { this, models in 
                    self.presenter.setup(models: models.map {
                        StorySmallTableViewCellModel.init(
                            storyId: $0.storyId,
                            thumbnailImageURL: $0.storyImage,
                            title: $0.title,
                            subtitle: $0.content,
                            likes: $0.likeCount,
                            comments: $0.commentCount
                        )
                    })
                }
                .onFailure { error in
                    Log.make(message:"\(String(describing: self)) \(error.localizedDescription)", log: .network)
                }
        }.store(in: cancelTaskBag)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.searchStorySeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        listener?.searchStorySeeAllDidTap(storyId: model.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        
    }

}
