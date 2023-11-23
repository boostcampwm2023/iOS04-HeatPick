//
//  SettingViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import CoreKit
import DesignKit

protocol SettingPresentableListener: AnyObject {
    func didTapClose()
    func didTapDiscussion()
    func didTapResign()
}

final class SettingViewController: UIViewController, SettingPresentable, SettingViewControllable {
    
    private enum Constant {
        static let topOffset: CGFloat = 40
        static let spacing: CGFloat = 20
    }
    
    weak var listener: SettingPresentableListener?
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.setup(model: .init(title: "설정", leftButtonType: .back, rightButtonTypes: []))
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private lazy var appVersionView = makeContentView(
        selector: #selector(didTapAppVersion),
        title: "앱 버전",
        subtitle: "1.0.0"
    )
    
    private lazy var discussionView = makeContentView(
        selector: #selector(didTapDiscussion),
        title: "문의하기"
    )
    
    private lazy var resignView = makeContentView(
        selector: #selector(didTapResign),
        title: "탈퇴하기"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension SettingViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.didTapClose()
    }
    
}

private extension SettingViewController {
    
    @objc func didTapAppVersion() {
        // 아무 일도 안함
    }
    
    @objc func didTapDiscussion() {
        listener?.didTapDiscussion()
    }
    
    @objc func didTapResign() {
        listener?.didTapResign()
    }
}

private extension SettingViewController {
    
    func setupViews() {
        let appVersionViewSeparator = makeSeparator()
        let discussionViewSeparator = makeSeparator()
        view.backgroundColor = .hpWhite
        
        [navigationView, appVersionView, appVersionViewSeparator, discussionView, discussionViewSeparator, resignView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            appVersionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: Constant.topOffset),
            appVersionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            appVersionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            appVersionViewSeparator.topAnchor.constraint(equalTo: appVersionView.bottomAnchor, constant: Constant.spacing),
            appVersionViewSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            appVersionViewSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            appVersionViewSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            discussionView.topAnchor.constraint(equalTo: appVersionViewSeparator.bottomAnchor, constant: Constant.spacing),
            discussionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            discussionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            discussionViewSeparator.topAnchor.constraint(equalTo: discussionView.bottomAnchor, constant: Constant.spacing),
            discussionViewSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            discussionViewSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            discussionViewSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            resignView.topAnchor.constraint(equalTo: discussionViewSeparator.bottomAnchor, constant: Constant.spacing),
            resignView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            resignView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset)
        ])
    }
    
    func makeContentView(selector: Selector, title: String, subtitle: String? = nil) -> SettingContentView {
        let contentView = SettingContentView()
        contentView.setup(title: title, subtitle: subtitle)
        contentView.addTapGesture(target: self, action: selector)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }
    
    func makeSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .hpGray4
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }
    
}
