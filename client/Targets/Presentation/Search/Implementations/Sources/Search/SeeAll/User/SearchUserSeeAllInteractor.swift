//
//  SearchUserSeeAllInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import CoreKit
import BasePresentation
import DomainInterfaces


protocol SearchUserSeeAllRouting: ViewableRouting { }

typealias SearchUserSeeAllPresentable = UserSeeAllPresentable
typealias SearchUserSeeAllPresentableListener = UserSeeAllPresentableListener

protocol SearchUserSeeAllListener: AnyObject {
    func searchUserSeeAllDidTapClose()
    func didTapUser(userId: Int)
}

protocol SearchUserSeeAllInteractorDependency: AnyObject {
    var searchText: String { get }
    var searchUserSeeAllUseCase: SearchUserSeeAllUseCaseInterface { get }
}

final class SearchUserSeeAllInteractor: PresentableInteractor<SearchUserSeeAllPresentable>,
                                            SearchUserSeeAllInteractable,
                                        SearchUserSeeAllPresentableListener{

    weak var router: SearchUserSeeAllRouting?
    weak var listener: SearchUserSeeAllListener?

    private let dependency: SearchUserSeeAllInteractorDependency
    
    private var cancelTaskBag: CancelBag = .init()
    
    init(
        presenter: SearchUserSeeAllPresentable,
        dependency: SearchUserSeeAllInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("사용자 검색")
        Task { [weak self] in
            guard let self else { return }
            await self.dependency.searchUserSeeAllUseCase
                .fetchUser(searchText: self.dependency.searchText)
                .onSuccess(on: .main, with: self) { _, models in
                    self.presenter.setup(models: models.map {
                        UserSmallTableViewCellModel(
                            userId: $0.userId,
                            username: $0.username,
                            profileUrl: $0.profileUrl
                        )
                    })
                }
                .onFailure { error in
                    Log.make(message:"\(String(describing: self)) \(error.localizedDescription)", log: .network)
                }
        }.store(in: cancelTaskBag)
    }

    override func willResignActive() {
        super.willResignActive()
        cancelTaskBag.cancel()
    }
    
    func didTapClose() {
        listener?.searchUserSeeAllDidTapClose()
    }
    
    func didTapItem(model: UserSmallTableViewCellModel) {
        listener?.didTapUser(userId: model.userId)
    }
    
}
