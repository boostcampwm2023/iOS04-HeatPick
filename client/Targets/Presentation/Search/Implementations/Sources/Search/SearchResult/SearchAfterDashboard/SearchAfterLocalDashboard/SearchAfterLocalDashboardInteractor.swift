//
//  SearchAfterLocalDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol SearchAfterLocalDashboardRouting: ViewableRouting {}

protocol SearchAfterLocalDashboardPresentable: Presentable {
    var listener: SearchAfterLocalDashboardPresentableListener? { get set }
    func setup(models: [SearchLocal])
}

protocol SearchAfterLocalDashboardListener: AnyObject {
    var searchResultLocalsPublisher: AnyPublisher<[SearchLocal], Never> { get }
    func searchAfterLocalDashboardDidTapLocal(_ local: SearchLocal)
}

final class SearchAfterLocalDashboardInteractor: PresentableInteractor<SearchAfterLocalDashboardPresentable>, SearchAfterLocalDashboardInteractable, SearchAfterLocalDashboardPresentableListener {

    weak var router: SearchAfterLocalDashboardRouting?
    weak var listener: SearchAfterLocalDashboardListener?

    private var cancellables: Set<AnyCancellable> = []
    
    override init(presenter: SearchAfterLocalDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        listener?.searchResultLocalsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.presenter.setup(models: users)
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTap(local: SearchLocal) {
        listener?.searchAfterLocalDashboardDidTapLocal(local)
    }
    
}
