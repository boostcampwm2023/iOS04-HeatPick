//
//  ResignDashboardInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import DomainInterfaces

protocol ResignDashboardRouting: ViewableRouting { }

protocol ResignDashboardPresentable: Presentable {
    var listener: ResignDashboardPresentableListener? { get set }
    
    func isResign(_ result: Bool)
}

protocol ResignDashboardListener: AnyObject {
    func didTapBack()
    func resign()
}

protocol ResignDashboardInteractorDependency: AnyObject {
    var myProfileResignUseCase: MyProfileResignUseCaseInterface { get }
}

final class ResignDashboardInteractor: PresentableInteractor<ResignDashboardPresentable>, ResignDashboardInteractable, ResignDashboardPresentableListener {

    weak var router: ResignDashboardRouting?
    weak var listener: ResignDashboardListener?

    private let cancelBag = CancelBag()
    private let dependency: ResignDashboardInteractorDependency

    init(
        presenter: ResignDashboardPresentable,
        dependency: ResignDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapBack() {
        listener?.didTapBack()
    }
    
    // TODO: 실패했을때는 ... 흠
    func resignButtonDidTap(_ message: String) {
        Task { [weak self] in
            guard let self else { return }
            await self.dependency.myProfileResignUseCase
                .requestResign(message: message)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.presenter.isResign(true)
                }
                .onFailure { error in
                    self.presenter.isResign(false)
                    Log.make(message: error.localizedDescription, log: .network)
                }
        }.store(in: cancelBag)
    }
    
    
    func resign() {
        listener?.resign()
    }
    
}
