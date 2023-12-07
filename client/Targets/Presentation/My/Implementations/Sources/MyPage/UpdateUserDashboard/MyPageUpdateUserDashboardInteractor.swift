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

protocol MyPageUpdateUserDashboardRouting: ViewableRouting { }

protocol MyPageUpdateUserDashboardPresentable: Presentable {
    var listener: MyPageUpdateUserDashboardPresentableListener? { get set }
    
    func setup(model: ProfileUpdateMetaData)
}

protocol MyPageUpdateUserDashboardListener: AnyObject {
    func updateUser(model: UserUpdateContent)
    func detachMyPageUpdateUserDasbaord()
}

protocol MyPageUpdateUserDashboardInteractorDependency: AnyObject {
    var myPageUpdateUserUseCase: MyPageUpdateUserUseCaseInterface { get }
}

final class MyPageUpdateUserDashboardInteractor: PresentableInteractor<MyPageUpdateUserDashboardPresentable>, MyPageUpdateUserDashboardInteractable, MyPageUpdateUserDashboardPresentableListener {
    
    weak var router: MyPageUpdateUserDashboardRouting?
    weak var listener: MyPageUpdateUserDashboardListener?
    
    private let dependency: MyPageUpdateUserDashboardInteractorDependency
    private var cancelTaskBag: CancelBag = .init()
    private var userUpdateModel: UserUpdateContent?
    
    init(
        presenter: MyPageUpdateUserDashboardPresentable,
        dependency: MyPageUpdateUserDashboardInteractorDependency
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
                    Task {
                        if let imageData = ImageCacheManager.shared.fetch(from: usermetaData.profileImageURL) {
                            self.userUpdateModel?.update(image: imageData)
                        }
                    }
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
        userUpdateModel?.update(username: username)
    }
    
    func didSelectBadge(_ badgeId: Int) {
        userUpdateModel?.update(selectedBadgeId: badgeId)
    }
    
    func didTapEditButton() {
        if let userUpdateModel { listener?.updateUser(model: userUpdateModel) }
        listener?.detachMyPageUpdateUserDasbaord()
    }
    
}
