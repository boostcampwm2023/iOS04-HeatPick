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
    func didTapRecommendText(_ recommendText: String)
}

protocol SearchingDashboardInteractorDependency: AnyObject {
    var searhResultsearchingUseCase: SearhResultSearchingUseCaseInterface { get }
}

final class SearchingDashboardInteractor: PresentableInteractor<SearchingDashboardPresentable>, SearchingDashboardInteractable, SearchingDashboardPresentableListener {
    
    weak var router: SearchingDashboardRouting?
    weak var listener: SearchingDashboardListener?
    
    private let dependecy: SearchingDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable> = []
    private var cancelBag: CancelBag = .init()
    
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
            .debounce(for: .seconds(0.05), scheduler: DispatchQueue.global())
            .sink { [weak self] editingText in
                guard let self else { return }
                Task {
                    await self.dependecy.searhResultsearchingUseCase
                        .fetchRecommendTexts(searchText:editingText)
                        .onSuccess(on: .main, with: self) { this, recommentTexts in
                            this.presenter.setup(recommendTexts: recommentTexts)
                        }
                        .onFailure { error in
                            Log.make(message: error.localizedDescription, log: .network)
                        }
                }.store(in: cancelBag)
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapRecommendText(_ recommendText: String) {
        listener?.didTapRecommendText(recommendText)
    }
}
