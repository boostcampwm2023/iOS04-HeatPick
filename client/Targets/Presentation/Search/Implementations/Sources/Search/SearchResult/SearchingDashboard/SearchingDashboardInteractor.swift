//
//  SearchingDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import DomainInterfaces

protocol SearchingDashboardRouting: ViewableRouting { }

protocol SearchingDashboardPresentable: Presentable {
    var listener: SearchingDashboardPresentableListener? { get set }
    
    func setup(recommendTexts: [String])
}

protocol SearchingDashboardListener: AnyObject {
    var editingSearchTextPublisher: AnyPublisher<String, Never> { get }
}

protocol SearchingDashboardInteractorDependency: AnyObject {
    var searhResultsearchingUseCase: SearhResultSearchingUseCaseInterface { get }
}

final class SearchingDashboardInteractor: PresentableInteractor<SearchingDashboardPresentable>, SearchingDashboardInteractable, SearchingDashboardPresentableListener {
    
    weak var router: SearchingDashboardRouting?
    weak var listener: SearchingDashboardListener?
    
    private let dependecy: SearchingDashboardInteractorDependency
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        presenter: SearchingDashboardPresentable,
        dependency: SearchingDashboardInteractorDependency
    ) {
        self.dependecy = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        listener?.editingSearchTextPublisher
            .sink { editingText in
                Task { [weak self] in
                    guard let self else { return }
                    await self.dependecy.searhResultsearchingUseCase
                        .fetchRecommendTexts(searchText:editingText)
                        .onSuccess(on: .main, with: self) { this, recommentTexts in
                            this.presenter.setup(recommendTexts: recommentTexts)
                        }
                        .onFailure { error in
                            Log.make(message: error.localizedDescription, log: .network)
                        }
                }
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func didTapItem(_ item: String) {
        
    }
}
