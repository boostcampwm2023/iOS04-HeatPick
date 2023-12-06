//
//  SignInViewController.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import Combine
import CoreKit
import DesignKit

protocol SignInPresentableListener: AnyObject {
    func githubButtonDidTap()
    func naverButtonDidTap()
}

public final class SignInViewController: UIViewController, SignInPresentable, SignInViewControllable {

    weak var listener: SignInPresentableListener?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let githubLoginButton: SignInButton = {
        let button = SignInButton()
        button.setup(type: .github)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let naverLoginButton: SignInButton = {
        let button = SignInButton()
        button.setup(type: .naver)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logoWithSubtitle)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
}

private extension SignInViewController {
    
    func bind() {
        githubLoginButton.tapPublisher
            .withOnly(self)
            .sink { $0.listener?.githubButtonDidTap() }
            .store(in: &cancellables)
        
        naverLoginButton.tapPublisher
            .withOnly(self)
            .sink { $0.listener?.naverButtonDidTap() }
            .store(in: &cancellables)
    }
    
    func setupViews() {
        view.backgroundColor = .white
        [logoImageView, githubLoginButton, naverLoginButton].forEach { view.addSubview($0) }
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            githubLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            githubLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            githubLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            githubLoginButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            
            naverLoginButton.bottomAnchor.constraint(equalTo: githubLoginButton.topAnchor, constant: -padding),
            naverLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            naverLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            naverLoginButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            logoImageView.bottomAnchor.constraint(equalTo: naverLoginButton.topAnchor)
        ])
    }
    
}
