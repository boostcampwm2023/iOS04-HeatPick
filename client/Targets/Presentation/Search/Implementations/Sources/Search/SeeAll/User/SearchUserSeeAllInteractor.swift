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
import DomainEntities
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
    func willDisplay(at indexPath: IndexPath) {
        
    }
    
    
    weak var router: SearchUserSeeAllRouting?
    weak var listener: SearchUserSeeAllListener?
    
    private let dependency: SearchUserSeeAllInteractorDependency
    private let cancelBag = CancelBag()
    private var models: [UserSmallTableViewCellModel] = []
    private var isLoading = false
    
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
        fetchUser()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.searchUserSeeAllDidTapClose()
    }
    
    func didTapItem(model: UserSmallTableViewCellModel) {
        listener?.didTapUser(userId: model.userId)
    }
    
    private func fetchUser() {
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchUserSeeAllUseCase
                .fetchUser(searchText: dependency.searchText)
                .onSuccess(on: .main, with: self) { this, users in
                    let models = users.toModels()
                    this.models = models
                    this.presenter.setup(models: models)
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    private func loadMoreIfNeeded() {
        guard dependency.searchUserSeeAllUseCase.hasMoreUser, isLoading == false else { return }
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchUserSeeAllUseCase
                .loadMoreUser(searchText: dependency.searchText)
                .onSuccess(on: .main, with: self) { this, users in
                    let models = users.toModels()
                    this.models.append(contentsOf: models)
                    this.presenter.append(models: models)
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    private func startLoading() {
        isLoading = true
        presenter.startLoading()
    }
    
    private func stopLoading() {
        isLoading = false
        presenter.stopLoading()
    }
    
}

private extension Array where Element == SearchUser {
    
    func toModels() -> [UserSmallTableViewCellModel] {
        return map {
            return .init(
                userId: $0.userId,
                username: $0.username,
                profileUrl: $0.profileUrl
            )
        }
    }
    
}
