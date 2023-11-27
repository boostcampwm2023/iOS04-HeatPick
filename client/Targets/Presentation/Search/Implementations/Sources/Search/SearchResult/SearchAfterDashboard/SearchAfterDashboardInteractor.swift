//
//  SearchAfterDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

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

protocol SearchAfterDashboardListener: AnyObject { }

protocol SearchAfterDashboardInteractorDependency: AnyObject {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { get }
}

final class SearchAfterDashboardInteractor: PresentableInteractor<SearchAfterDashboardPresentable>, SearchAfterDashboardInteractable, SearchAfterDashboardPresentableListener {

    weak var router: SearchAfterDashboardRouting?
    weak var listener: SearchAfterDashboardListener?

    private let dependency: SearchAfterDashboardInteractorDependency
    
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
    }

    override func willResignActive() {
        super.willResignActive()
        router?.detachSearchAfterStoryDashboard()
        router?.detachSearchAfterUserDashboard()
    }
    
}
