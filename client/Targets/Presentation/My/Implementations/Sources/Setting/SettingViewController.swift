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
    func didTapMailTo()
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
    
    private lazy var mailToView = makeContentView(
        selector: #selector(didTapMailTo),
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
    
    @objc func didTapMailTo() {
        listener?.didTapMailTo()
    }
    
    @objc func didTapResign() {
        listener?.didTapResign()
    }
}

private extension SettingViewController {
    
    func setupViews() {
        let appVersionViewSeparator = makeSeparator()
        let mailToViewSeparator = makeSeparator()
        view.backgroundColor = .hpWhite
        
        [navigationView, appVersionView, appVersionViewSeparator, mailToView, mailToViewSeparator, resignView].forEach(view.addSubview)
        
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
            
            mailToView.topAnchor.constraint(equalTo: appVersionViewSeparator.bottomAnchor, constant: Constant.spacing),
            mailToView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            mailToView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            mailToViewSeparator.topAnchor.constraint(equalTo: mailToView.bottomAnchor, constant: Constant.spacing),
            mailToViewSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            mailToViewSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            mailToViewSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            resignView.topAnchor.constraint(equalTo: mailToViewSeparator.bottomAnchor, constant: Constant.spacing),
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
