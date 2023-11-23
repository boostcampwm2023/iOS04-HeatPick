//
//  SettingInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs

protocol SettingRouting: ViewableRouting {}

protocol SettingPresentable: Presentable {
    var listener: SettingPresentableListener? { get set }
    func openURL(_ url: URL)
}

protocol SettingListener: AnyObject {
    func settingDidTapClose()
}

final class SettingInteractor: PresentableInteractor<SettingPresentable>, SettingInteractable, SettingPresentableListener {
    
    weak var router: SettingRouting?
    weak var listener: SettingListener?
    
    override init(presenter: SettingPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.settingDidTapClose()
    }
    
    func didTapDiscussion() {
        let discussionURL = "https://github.com/boostcampwm2023/iOS04-HeatPick/discussions/293"
        guard let url = URL(string: discussionURL) else { return }
        presenter.openURL(url)
    }
    
    func didTapResign() {
        print("# 회원탈퇴 Attach")
    }
    
}
