//
//  SearchAfterDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol SearchAfterDashboardRouting: ViewableRouting { 
    func attachSearchAfterStoryDashboard()
    func detachSearchAfterStoryDashboard()
    
    func attachSearchAfterUserDashboard()
    func detachSearchAfterUserDashboard()
    
    func attachSearchAfterLocalDasboard()
    func detachSearchAfterLocalDasboard()
}

protocol SearchAfterDashboardPresentable: Presentable {
    var listener: SearchAfterDashboardPresentableListener? { get set }
}

protocol SearchAfterDashboardListener: AnyObject {
    var endEditingSearchTextPublisher: AnyPublisher<String, Never> { get }
    
    func searchStorySeeAllDidTap(searchText: String)
    func didTapStory(storyId: Int)
    
    func searchUserSeeAllDidTap(searchText: String)
    func didTapUser(userId: Int)
}

final class SearchAfterDashboardInteractor: PresentableInteractor<SearchAfterDashboardPresentable>, SearchAfterDashboardInteractable, SearchAfterDashboardPresentableListener {
    
    weak var router: SearchAfterDashboardRouting?
    weak var listener: SearchAfterDashboardListener?

    private let dependency: SearchAfterDashboardInteractorDependency
    
    var searchResultStoriesPublisher: AnyPublisher<[SearchStory], Never> { searchResultStoriesSubject.eraseToAnyPublisher() }
    var searchResultUsersPublisher: AnyPublisher<[SearchUser], Never> { searchResultUsersSubject.eraseToAnyPublisher() }
    var searchResultLocalsPublisher: AnyPublisher<[SearchLocal], Never> { searchResultLocalsSubject.eraseToAnyPublisher() }
    
    private var searchResultStoriesSubject: PassthroughSubject<[SearchStory], Never> = .init()
    private var searchResultUsersSubject: PassthroughSubject<[SearchUser], Never> = .init()
    private var searchResultLocalsSubject: PassthroughSubject<[SearchLocal], Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    private var cancelTaskBag: CancelBag = .init()
    private var searchText: String?
    
    init(
        presenter: SearchAfterDashboardPresentable,
        dependency: SearchAfterDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchAfterLocalDasboard()
        router?.attachSearchAfterStoryDashboard()
        router?.attachSearchAfterUserDashboard()
        
        listener?.endEditingSearchTextPublisher
            .sink { [weak self] searchText in
                guard let self else { return }
                Task {
                    await self.dependency.searhResultSearchAfterUseCase
                        .fetchResult(searchText: searchText)
                        .onSuccess { searchResult in
                            self.searchText = searchText
                            self.searchResultStoriesSubject.send(searchResult.stories)
                            self.searchResultUsersSubject.send(searchResult.users)
                        }
                        .onFailure { error in
                            Log.make(message: error.localizedDescription, log: .network)
                            self.searchText = nil
                        }
                }.store(in: cancelTaskBag)
                
                Task {
                    await self.dependency.searhResultSearchAfterUseCase
                        .fetchNaverLocal(query: searchText)
                        .onSuccess { naverSearchLocals in
                            self.searchResultLocalsSubject.send(naverSearchLocals)
                        }
                        .onFailure { error in
                            Log.make(message: error.localizedDescription, log: .network)
                            self.searchText = nil
                        }
                }.store(in: cancelTaskBag)
            }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        cancelTaskBag.cancel()
        router?.detachSearchAfterLocalDasboard()
        router?.detachSearchAfterStoryDashboard()
        router?.detachSearchAfterUserDashboard()
    }
    
}

// MARK: SearchAfterStroy
extension SearchAfterDashboardInteractor {
    
    func searchStorySeeAllDidTap() {
        guard let searchText else { return }
        listener?.searchStorySeeAllDidTap(searchText: searchText)
    }
    
    func didTapStory(storyId: Int) {
        listener?.didTapStory(storyId: storyId)
    }
    
}

// MARK: SearchAfterUser
extension SearchAfterDashboardInteractor {
    
    func searchUserSeeAllDidTap() {
        guard let searchText else { return }
        listener?.searchUserSeeAllDidTap(searchText: searchText)
    }
    
    func didTapUser(userId: Int) {
        listener?.didTapUser(userId: userId)
    }

}
