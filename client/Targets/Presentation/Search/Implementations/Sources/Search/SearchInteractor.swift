//
//  SearchInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainEntities
import BasePresentation

protocol SearchRouting: ViewableRouting {
    func attachSearchMap()
    func detachSearchMap()
    
    func attachSearchCurrentLocation()
    func detachSearchCurrentLocation()
    
    func attachSearchResult()
    func detachSearchResult()
    
    func attachStoryDetail(storyID: Int)
    func detachStoryDetail()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    func showStoryView(model: SearchMapStoryViewModel)
    func hideStoryView()
}

public protocol SearchListener: AnyObject { }

final class SearchInteractor: PresentableInteractor<SearchPresentable>,
                              AdaptivePresentationControllerDelegate,
                              SearchInteractable,
                              SearchPresentableListener {
    
    weak var router: SearchRouting?
    weak var listener: SearchListener?
    let presentationAdapter: AdaptivePresentationControllerDelegateAdapter
    
    override init(presenter: SearchPresentable) {
        self.presentationAdapter = AdaptivePresentationControllerDelegateAdapter()
        super.init(presenter: presenter)
        presenter.listener = self
        presentationAdapter.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchMap()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func attachSearchResult() {
        router?.attachSearchResult()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
    }
    
    func didTapCurrentLocation() {
        router?.attachSearchCurrentLocation()
    }
    
    func didTapStory(storyID: Int) {
        router?.attachStoryDetail(storyID: storyID)
    }
    
    func controllerDidDismiss() {
        router?.detachSearchCurrentLocation()
    }
    
    // MARK: - Search Map
    
    func searchMapDidTapMarker(place: Place) {
        let story = place.story
        presenter.showStoryView(model: .init(
            storyID: story.id,
            thumbnailImageURL: story.imageURLs.first ?? "",
            title: story.title,
            subtitle: story.content,
            likes: story.likeCount,
            comments: story.commentCount
        ))
    }
    
    func searchMapWillMove() {
        presenter.hideStoryView()
    }
    
    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
    }
    
}
