//
//  FollowListInteractor.swift
//  MyImplementations
//
//  Created by jungmin lim on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import FoundationKit
import BasePresentation
import DomainEntities
import DomainInterfaces

protocol FollowListRouting: ViewableRouting {
    func attachProfile(userId: Int)
    func detachProfile()
}

protocol FollowListPresentable: Presentable {
    var listener: FollowListPresentableListener? { get set }
    func setup(model: [UserSmallTableViewCellModel])
    func present(type: AlertType, okAction: @escaping (() -> Void))
}

protocol FollowListInteractorDependency: AnyObject {
    var userId: Int? { get set }
    var type: FollowType { get }
    var myProfileUseCase: MyProfileUseCaseInterface { get }
    var userProfileUseCase: UserProfileUseCaseInterface { get }
}

protocol FollowListListener: AnyObject { 
    func followListBackButtonDidTap()
}

final class FollowListInteractor: PresentableInteractor<FollowListPresentable>,
                                  FollowListInteractable,
                                  FollowListPresentableListener {

    weak var router: FollowListRouting?
    weak var listener: FollowListListener?
    
    private let dependency: FollowListInteractorDependency
    private let cancelBag = CancelBag()
    
    init(presenter: FollowListPresentable,
         dependency: FollowListInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchList()
    }

    override func willResignActive() {
        super.willResignActive()
        dependency.userId = nil
        cancelBag.cancel()
    }
    
    var title: String {
        dependency.type.rawValue
    }
    
    func backButtonDidTap() {
        listener?.followListBackButtonDidTap()
    }
    
    func didTapUser(userId: Int) {
        router?.attachProfile(userId: userId)
    }
    
    func detachUserProfile() {
        router?.detachProfile()
    }
}

private extension FollowListInteractor {
    func fetchList() {
        if let userId = dependency.userId {
            switch dependency.type {
            case .follower:
                fetchFollowers(of: userId)
            case .following:
                fetchFollowings(of: userId)
            }
        }
        else {
            switch dependency.type {
            case .follower:
                fetchMyFollowers()
            case .following:
                fetchMyFollowings()
            }
        }
    }
    
    func fetchMyFollowers() {
        Task { [weak self] in
            guard let self else { return }
            
            await dependency.myProfileUseCase
                .fetchFollowers()
                .onSuccess(on: .main, with: self) { this, users in
                    this.presenter.setup(model: users.map { $0.toModel() })
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load my follwers with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToLoadFollowList) {
                        this.listener?.followListBackButtonDidTap()
                    }
                }
        }.store(in: cancelBag)
    }
    
    func fetchMyFollowings() {
        Task { [weak self] in
            guard let self else { return }
            
            await dependency.myProfileUseCase
                .fetchFollowings()
                .onSuccess(on: .main, with: self) { this, users in
                    this.presenter.setup(model: users.map { $0.toModel() })
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load my follwers with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToLoadFollowList) {
                        this.listener?.followListBackButtonDidTap()
                    }
                }
        }.store(in: cancelBag)
    }
    
    func fetchFollowers(of userId: Int) {
        Task { [weak self] in
            guard let self else { return }
            
            await dependency.userProfileUseCase
                .fetchFollowers(userId: userId)
                .onSuccess(on: .main, with: self) { this, users in
                    this.presenter.setup(model: users.map { $0.toModel() })
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load my follwers with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToLoadFollowList) {
                        this.listener?.followListBackButtonDidTap()
                    }
                }
        }.store(in: cancelBag)
    }
    
    func fetchFollowings(of userId: Int) {
        Task { [weak self] in
            guard let self else { return }
            
            await dependency.userProfileUseCase
                .fetchFollowings(userId: userId)
                .onSuccess(on: .main, with: self) { this, users in
                    this.presenter.setup(model: users.map { $0.toModel() })
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load my follwers with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToLoadFollowList) {
                        this.listener?.followListBackButtonDidTap()
                    }
                }
        }.store(in: cancelBag)
    }
}

fileprivate extension SearchUser {
    func toModel() -> UserSmallTableViewCellModel {
        .init(userId: userId, username: username, profileUrl: profileUrl)
    }
}
