//
//  SettingViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine
import ModernRIBs
import CoreKit
import DesignKit
import BasePresentation

protocol SettingPresentableListener: AnyObject {
    func didTapClose()
    func didTapDiscussion()
    func didTapLocation()
    func didTapNotification()
    func didTapResign()
    func didTapSignOut()
}

final class SettingViewController: BaseViewController, SettingPresentable, SettingViewControllable {
    
    private enum Constant {
        static let topOffset: CGFloat = 40
        static let spacing: CGFloat = 20
    }
    
    weak var listener: SettingPresentableListener?
    
    private let stackView = UIStackView()
    
    private lazy var appVersionView = makeContentView(
        title: "앱 버전",
        subtitle: AppBundle.appVersion,
        isTopContent: true
    )
    
    private lazy var discussionView = makeContentView(
        title: "문의하기"
    )
    
    private lazy var locationView = makeContentView(
        title: "위치 권한",
        subtitle: ""
    )
    
    private lazy var notificationView = makeContentView(
        title: "알림 권한",
        subtitle: ""
    )
    
    private lazy var resignView = makeContentView(
        title: "탈퇴하기"
    )
    
    private lazy var signOutView = makeContentView(
        title: "로그아웃하기"
    )
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func openSettingApp() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    func updateLocationSubtitle(_ subtitle: String) {
        locationView.setup(title: "위치 권한", subtitle: subtitle)
    }
    
    func updateNotificationSubtitle(_ subtitle: String) {
        notificationView.setup(title: "알림 권한", subtitle: subtitle)
    }
    
    override func setupLayout() {
        [navigationView, stackView].forEach(view.addSubview)
        [appVersionView, discussionView, locationView, notificationView, resignView, signOutView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            stackView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset)
        ])
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        navigationView.do {
            $0.setup(model: .init(title: "설정", leftButtonType: .back, rightButtonTypes: []))
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        discussionView.tapGesturePublisher
            .receive(on: DispatchQueue.main)
            .withOnly(self)
            .sink { this in
                this.listener?.didTapDiscussion()
            }
            .store(in: &cancellables)
        
        resignView.tapGesturePublisher
            .receive(on: DispatchQueue.main)
            .withOnly(self)
            .sink { this in
                this.listener?.didTapResign()
            }
            .store(in: &cancellables)
        
        locationView.tapGesturePublisher
            .receive(on: DispatchQueue.main)
            .withOnly(self)
            .sink { this in
                this.listener?.didTapLocation()
            }
            .store(in: &cancellables)
        
        notificationView.tapGesturePublisher
            .receive(on: DispatchQueue.main)
            .withOnly(self)
            .sink { this in
                this.listener?.didTapNotification()
            }
            .store(in: &cancellables)
        
        signOutView.tapGesturePublisher
            .receive(on: DispatchQueue.main)
            .withOnly(self)
            .sink { this in
                this.listener?.didTapSignOut()
            }
            .store(in: &cancellables)
    }
    
}

extension SettingViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.didTapClose()
    }
    
}

private extension SettingViewController {
    
    func makeContentView(title: String, subtitle: String? = nil, isTopContent: Bool = false) -> SettingContentView {
        let contentView = SettingContentView()
        contentView.setup(title: title, subtitle: subtitle)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        if isTopContent {
            contentView.hideSeparator()
        }
        
        return contentView
    }
    
}
