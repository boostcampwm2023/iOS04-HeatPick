//
//  UserInfoEditDashboardInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs

protocol UserInfoEditDashboardRouting: ViewableRouting { }

protocol UserInfoEditDashboardPresentable: Presentable {
    var listener: UserInfoEditDashboardPresentableListener? { get set }
    
    func setup(model: UserInfoEditViewModel)
}

protocol UserInfoEditDashboardListener: AnyObject {
    func didTapBackUserInfoEditDashboard()
}

final class UserInfoEditDashboardInteractor: PresentableInteractor<UserInfoEditDashboardPresentable>, UserInfoEditDashboardInteractable, UserInfoEditDashboardPresentableListener {

    weak var router: UserInfoEditDashboardRouting?
    weak var listener: UserInfoEditDashboardListener?

    override init(presenter: UserInfoEditDashboardPresentable) {
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
