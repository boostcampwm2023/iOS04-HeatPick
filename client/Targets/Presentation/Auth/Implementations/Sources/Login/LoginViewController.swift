//
//  LoginViewController.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol LoginPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

public final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

    weak var listener: LoginPresentableListener?
    
    private let naverLoginButton: LoginButton = {
        let button = LoginButton()
        button.setup(type: .naver)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let appleLoginButton: LoginButton = {
        let button = LoginButton()
        button.setup(type: .apple)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension LoginViewController {
    func setupViews() {
        let padding: CGFloat = 20
        let height: CGFloat = 50
        
        view.backgroundColor = .white
        view.addSubview(naverLoginButton)
        view.addSubview(appleLoginButton)
        
        NSLayoutConstraint.activate([
            appleLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            appleLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            appleLoginButton.heightAnchor.constraint(equalToConstant: height),
            
            naverLoginButton.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -padding),
            naverLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            naverLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            naverLoginButton.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
