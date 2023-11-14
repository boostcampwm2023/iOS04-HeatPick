//
//  LocationAuthorityViewController.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

protocol LocationAuthorityPresentableListener: AnyObject {
    func didTapNext()
    func didTapSkip()
}

public final class LocationAuthorityViewController: UIViewController, LocationAuthorityPresentable, LocationAuthorityViewControllable {
    
    private enum Constant {
        static let title = "힛픽은 지도를 사용하는 앱이에요"
        static let subtitle = "위치 권한이 있어야 원활한 사용이 가능해요"
        static let nextButtonTitle = "다음"
        static let skipButtonTitle = "건너뛰기"
        static let itemSpacing: CGFloat = 5
        static let imageSpacing: CGFloat = 30
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = imageWidth
        static let buttonSpacing: CGFloat = 10
    }
    
    weak var listener: LocationAuthorityPresentableListener?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constant.itemSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constant.buttonSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .map
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.title
        label.textColor = .hpBlack
        label.font = .largeSemibold
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.subtitle
        label.textColor = .hpBlack
        label.font = .captionRegular
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nextButton: ActionButton = {
        let button = ActionButton()
        button.style = .normal
        button.setTitle(Constant.nextButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        return button
    }()
    
    private lazy var skipButton: ActionButton = {
        let button = ActionButton()
        button.style = .secondary
        button.setTitle(Constant.skipButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func openSettingApp() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}

private extension LocationAuthorityViewController {
    
    @objc func nextButtonDidTap() {
        listener?.didTapNext()
    }
    
    @objc func skipButtonDidTap() {
        listener?.didTapSkip()
    }
    
}

private extension LocationAuthorityViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        [stackView, buttonStackView].forEach(view.addSubview)
        [imageView, titleLabel, subtitleLabel].forEach(stackView.addArrangedSubview)
        [skipButton, nextButton].forEach(buttonStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Constants.actionButtonHeight),
            
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
        ])
        
        stackView.setCustomSpacing(Constant.imageSpacing, after: imageView)
    }
    
}
