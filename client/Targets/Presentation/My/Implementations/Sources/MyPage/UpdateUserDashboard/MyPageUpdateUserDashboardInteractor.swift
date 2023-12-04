//
//  MyPageUpdateUserDashboardInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import DomainEntities
import DomainInterfaces

protocol MyPageUpdateUserDashboardRouting: ViewableRouting { }

protocol MyPageUpdateUserDashboardPresentable: Presentable {
    var listener: MyPageUpdateUserDashboardPresentableListener? { get set }
    
    func setup(model: UserInfoEditViewModel)
}

protocol MyPageUpdateUserDashboardListener: AnyObject {
    func didTapBackUserInfoEditDashboard()
}

protocol MyPageUpdateUserDashboardInteractorDependency: AnyObject {
    var myPageUpdateUserUseCase: MyPageUpdateUserUseCaseInterface { get }
}

final class MyPageUpdateUserDashboardInteractor: PresentableInteractor<MyPageUpdateUserDashboardPresentable>, MyPageUpdateUserDashboardInteractable, MyPageUpdateUserDashboardPresentableListener {

    weak var router: MyPageUpdateUserDashboardRouting?
    weak var listener: MyPageUpdateUserDashboardListener?

    private let dependency: MyPageUpdateUserDashboardInteractorDependency
    
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
//        presenter.setup(model: )
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapBack() {
        listener?.didTapBackUserInfoEditDashboard()
    }
    
    func profileImageViewDidChange(_ imageData: Data) {
        
    }
    
    func usernameValueChanged(_ username: String) {
        
    }
    
    func didTapUserBadgeView(_ badgeId: Int) {
        
    }
    
    func didTapEditButton() {
        
    }
    
}
