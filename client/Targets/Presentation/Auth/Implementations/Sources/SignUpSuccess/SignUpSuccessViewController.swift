//
//  SignUpSuccessViewController.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

protocol SignUpSuccessPresentableListener: AnyObject {
    func didTapNext()
}

public final class SignUpSuccessViewController: UIViewController, SignUpSuccessPresentable, SignUpSuccessViewControllable {
    
    private enum Constant {
        static let title = "회원가입이 되었어요"
        static let subtitle = "힛픽에 오신 것을 환영해요"
        static let nextButtonTitle = "다음"
        static let itemSpacing: CGFloat = 5
        static let imageSpacing: CGFloat = 30
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = imageWidth
    }

    weak var listener: SignUpSuccessPresentableListener?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constant.itemSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .congratulation
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension SignUpSuccessViewController {
    
    @objc func nextButtonDidTap() {
        listener?.didTapNext()
    }
    
}

private extension SignUpSuccessViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        [stackView, nextButton].forEach(view.addSubview)
        [imageView, titleLabel, subtitleLabel].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Constants.actionButtonHeight),
            
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
        ])
        
        stackView.setCustomSpacing(Constant.imageSpacing, after: imageView)
    }
    
}
