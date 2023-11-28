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
}

protocol SearchAfterDashboardPresentable: Presentable {
    var listener: SearchAfterDashboardPresentableListener? { get set }
}

protocol SearchAfterDashboardListener: AnyObject {
    var endEditingSearchTextPublisher: AnyPublisher<String, Never> { get }
}

protocol SearchAfterDashboardInteractorDependency: AnyObject {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { get }
}

final class SearchAfterDashboardInteractor: PresentableInteractor<SearchAfterDashboardPresentable>, SearchAfterDashboardInteractable, SearchAfterDashboardPresentableListener {

    weak var router: SearchAfterDashboardRouting?
    weak var listener: SearchAfterDashboardListener?

    private let dependency: SearchAfterDashboardInteractorDependency
    
    var searchResultStoriesPublisher: AnyPublisher<[SearchStory], Never> { searchResultStoriesSubject.eraseToAnyPublisher() }
    var searchResultUsersPublisher: AnyPublisher<[SearchUser], Never> { searchResultUsersSubject.eraseToAnyPublisher() }
    
    private var searchResultStoriesSubject: PassthroughSubject<[SearchStory], Never> = .init()
    private var searchResultUsersSubject: PassthroughSubject<[SearchUser], Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
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
        router?.attachSearchAfterStoryDashboard()
        router?.attachSearchAfterUserDashboard()
        
        listener?.endEditingSearchTextPublisher
            .sink { searchText in
                Task { [weak self] in
                    guard let self else { return }
                    await self.dependency.searhResultSearchAfterUseCase
                        .fetchResult(searchText: searchText)
                        .onSuccess { searchResult in
                            self.searchResultStoriesSubject.send(searchResult.stories)
                            self.searchResultUsersSubject.send(searchResult.users)
                        }
                        .onFailure { error in
                            Log.make(message: error.localizedDescription, log: .network)
                        }
                }
            }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        router?.detachSearchAfterStoryDashboard()
        router?.detachSearchAfterUserDashboard()
    }
    
}
