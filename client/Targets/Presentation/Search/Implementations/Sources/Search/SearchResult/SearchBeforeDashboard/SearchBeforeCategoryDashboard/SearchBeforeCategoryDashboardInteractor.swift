//
//  SearchBeforeCategoryDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol SearchBeforeCategoryDashboardRouting: ViewableRouting { }

protocol SearchBeforeCategoryDashboardPresentable: Presentable {
    var listener: SearchBeforeCategoryDashboardPresentableListener? { get set }
    
    func setup(models: [SearchCategory])
}

protocol SearchBeforeCategoryDashboardListener: AnyObject {
    func categoryViewDidTap(_ category: SearchCategory)
}

protocol SearchBeforeCategoryDashboardInteractorDependency: AnyObject {
    var searchBeforeCategoryUseCase: SearchBeforeCategoryUseCaseInterface { get }
}

final class SearchBeforeCategoryDashboardInteractor: PresentableInteractor<SearchBeforeCategoryDashboardPresentable>, SearchBeforeCategoryDashboardInteractable, SearchBeforeCategoryDashboardPresentableListener {
    
    weak var router: SearchBeforeCategoryDashboardRouting?
    weak var listener: SearchBeforeCategoryDashboardListener?
    
    private var cancelBag: CancelBag = .init()

    private let dependency: SearchBeforeCategoryDashboardInteractorDependency
    
    init(
        presenter: SearchBeforeCategoryDashboardPresentable,
        dependency: SearchBeforeCategoryDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        Task { [weak self] in
            guard let self else { return }
            await self.dependency.searchBeforeCategoryUseCase
                .fetchCategory()
                .onSuccess(on: .main, with: self) { this, models in
                    this.presenter.setup(models: models)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .network)
                }
        }.store(in: cancelBag)
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }

    func categoryViewDidTap(_ category: SearchCategory) {
        listener?.categoryViewDidTap(category)
    }
    
}
