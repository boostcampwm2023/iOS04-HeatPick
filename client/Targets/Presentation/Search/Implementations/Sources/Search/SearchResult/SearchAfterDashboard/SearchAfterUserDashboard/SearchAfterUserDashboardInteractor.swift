//
//  SearchAfterUserDashboardInteractor.swift
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

protocol SearchAfterUserDashboardRouting: ViewableRouting { }

protocol SearchAfterUserDashboardPresentable: Presentable {
    var listener: SearchAfterUserDashboardPresentableListener? { get set }
    func setup(models: [SearchUser])
}

protocol SearchAfterUserDashboardListener: AnyObject {
    var searchResultUsersPublisher: AnyPublisher<[SearchUser], Never> { get }
}

final class SearchAfterUserDashboardInteractor: PresentableInteractor<SearchAfterUserDashboardPresentable>, SearchAfterUserDashboardInteractable, SearchAfterUserDashboardPresentableListener {
    
    weak var router: SearchAfterUserDashboardRouting?
    weak var listener: SearchAfterUserDashboardListener?
    
    private var cancellables: Set<AnyCancellable> = []
    
    override init(presenter: SearchAfterUserDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        listener?.searchResultUsersPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.presenter.setup(models: users)
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func searchAfterHeaderViewSeeAllViewDidTap() {
        // TODO: 성준님이 만드신 뷰와 연결
    }
}
