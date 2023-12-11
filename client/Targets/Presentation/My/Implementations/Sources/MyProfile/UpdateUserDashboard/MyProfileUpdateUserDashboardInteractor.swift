//
//  MyPageUpdateUserDashboardInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol MyProfileUpdateUserDashboardRouting: ViewableRouting { }

protocol MyProfileUpdateUserDashboardPresentable: Presentable {
    var listener: MyProfileUpdateUserDashboardPresentableListener? { get set }
    
    func setup(model: ProfileUpdateMetaData)
    func stopLoading()
    func updateAvailableUsernameLabel(_ available: Bool)
}

protocol MyProfileUpdateUserDashboardListener: AnyObject {
    func detachMyPageUpdateUserDasbaord()
}

protocol MyProfileUpdateUserDashboardInteractorDependency: AnyObject {
    var myPageUpdateUserUseCase: MyProfileUpdateUserUseCaseInterface { get }
}

final class MyProfileUpdateUserDashboardInteractor: PresentableInteractor<MyProfileUpdateUserDashboardPresentable>, MyProfileUpdateUserDashboardInteractable, MyProfileUpdateUserDashboardPresentableListener {
    
    weak var router: MyProfileUpdateUserDashboardRouting?
    weak var listener: MyProfileUpdateUserDashboardListener?
    
    private let dependency: MyProfileUpdateUserDashboardInteractorDependency
    private var cancelTaskBag: CancelBag = .init()
    private var userUpdateModel: UserUpdateContent?
    
    init(
        presenter: MyProfileUpdateUserDashboardPresentable,
        dependency: MyProfileUpdateUserDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        Task { [weak self] in
            guard let self else { return }
            await self.dependency.myPageUpdateUserUseCase.fetchUserMedtaData()
                .onSuccess(on: .main) { usermetaData in
                    self.presenter.setup(model: usermetaData)
                    self.userUpdateModel = .init(username: usermetaData.username, selectedBadgeId: usermetaData.nowBadge.badgeId)
                    // TODO: 서버에서 이미지 없을 시 기존 이미지 사용하게 수정 요청
//                    Task {
//                        if let imageData = ImageCacheManager.shared.fetch(from: usermetaData.profileImageURL) {
//                            self.userUpdateModel?.update(image: imageData)
//                        }
//                    }
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .network)
                }
        }.store(in: cancelTaskBag)
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelTaskBag.cancel()
    }
    
    func didTapBack() {
        listener?.detachMyPageUpdateUserDasbaord()
    }
    
    func profileImageViewDidChange(_ imageData: Data) {
        userUpdateModel?.update(image: imageData)
    }
    
    func usernameValueChanged(_ username: String) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.myPageUpdateUserUseCase
                .checkUsername(username: username)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.presenter.updateAvailableUsernameLabel(true)
                    this.userUpdateModel?.update(username: username)
                }
                .onFailure(on: .main, with: self) { this, _ in
                    this.presenter.updateAvailableUsernameLabel(false)
                }
        }.store(in: cancelTaskBag)
    }
    
    func didSelectBadge(_ badgeId: Int) {
        userUpdateModel?.update(selectedBadgeId: badgeId)
    }
    
    func didTapEditButton() {
        Task { [weak self] in
            guard let self,
                  let userUpdateModel else { return }
            await dependency.myPageUpdateUserUseCase
                .patchUserUpdate(userUpdate: userUpdateModel)
                .onSuccess(on: .main, with: self) { this, userId in
                    this.listener?.detachMyPageUpdateUserDasbaord()
                }.onFailure { error in
                    self.presenter.stopLoading()
                    Log.make(message: error.localizedDescription, log: .network)
                }
        }.store(in: cancelTaskBag)
    }
    
}
