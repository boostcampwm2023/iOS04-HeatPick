//
//  NotificationPermissionViewController.swift
//  AuthImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine
import ModernRIBs
import CoreKit
import DesignKit
import BasePresentation

protocol NotificationPermissionPresentableListener: AnyObject {
    func didTapNext()
    func didTapSkip()
}

final class NotificationPermissionViewController: BaseViewController, NotificationPermissionPresentable, NotificationPermissionViewControllable {
    
    private enum Constant {
        static let title = "힛픽은 알림을 사용하는 앱이에요"
        static let subtitle = "알림 권한이 있으면 더 풍부하게 즐길 수 있어요!"
        static let nextButtonTitle = "다음"
        static let skipButtonTitle = "건너뛰기"
        static let itemSpacing: CGFloat = 5
        static let imageSpacing: CGFloat = 30
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = imageWidth
        static let buttonSpacing: CGFloat = 10
        static let bottomSpacing: CGFloat = 20
    }
    
    weak var listener: NotificationPermissionPresentableListener?
    
    private let stackView = UIStackView()
    private let buttonStackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nextButton = ActionButton()
    private let skipButton = ActionButton()
    
    func openSettingApp() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    override func setupLayout() {
        [stackView, buttonStackView].forEach(view.addSubview)
        [imageView, titleLabel, subtitleLabel].forEach(stackView.addArrangedSubview)
        [skipButton, nextButton].forEach(buttonStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.bottomSpacing),
            buttonStackView.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Constants.actionButtonHeight),
            
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
        ])
        
        stackView.setCustomSpacing(Constant.imageSpacing, after: imageView)
    }
    
    override func setupAttributes() {
        isPopGestureEnabled = false
        view.backgroundColor = .hpWhite
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = Constant.itemSpacing
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .fill
            $0.spacing = Constant.buttonSpacing
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageView.do {
            $0.image = .bell
            $0.contentMode = .scaleAspectFill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do {
            $0.text = Constant.title
            $0.textColor = .hpBlack
            $0.font = .largeSemibold
            $0.textAlignment = .center
        }
        
        subtitleLabel.do {
            $0.text = Constant.subtitle
            $0.textColor = .hpBlack
            $0.font = .captionRegular
            $0.textAlignment = .center
        }
        
        nextButton.do {
            $0.style = .normal
            $0.setTitle(Constant.nextButtonTitle, for: .normal)
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
        }
        
        skipButton.do {
            $0.style = .secondary
            $0.setTitle(Constant.skipButtonTitle, for: .normal)
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
        }
    }
    
    override func bind() {
        nextButton.tapPublisher
            .withOnly(self)
            .sink { this in
                this.listener?.didTapNext()
            }
            .store(in: &cancellables)
        
        skipButton.tapPublisher
            .withOnly(self)
            .sink { this in
                this.listener?.didTapSkip()
            }
            .store(in: &cancellables)
    }
    
}
