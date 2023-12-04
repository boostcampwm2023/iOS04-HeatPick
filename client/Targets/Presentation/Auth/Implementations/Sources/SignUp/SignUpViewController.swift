//
//  SignUpViewController.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import PhotosUI
import ModernRIBs
import CoreKit
import DesignKit
import BasePresentation

protocol SignUpPresentableListener: AnyObject {
    func profileImageViewDidChange(_ imageData: Data)
    func signUpButtonDidTap()
    func nicknameDidChange(_ nickname: String)
    func didTapClose()
}

final class SignUpViewController: BaseViewController, SignUpPresentable, SignUpViewControllable {
    
    private enum Constant {
        static let imageHeight: CGFloat = 100
    }
    
    weak var listener: SignUpPresentableListener?
    
    private let profileImageView = UIImageView(image: .profileDefault)
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let signUpButton = ActionButton()
    
    func updateButtonEnabled(_ isEnabled: Bool) {
        signUpButton.isEnabled = isEnabled
    }
    
    override func setupLayout() {
        let padding: CGFloat = 30
        
        [navigationView, profileImageView, nicknameLabel, nicknameTextField, signUpButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: padding),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.imageHeight),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            nicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: padding),
            
            nicknameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            nicknameTextField.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: padding),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 46),
            
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            signUpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            signUpButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -padding),
            signUpButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight)
        ])
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        navigationView.do {
            $0.setup(model: .init(title: "회원가입", leftButtonType: .back, rightButtonTypes: []))
            $0.delegate = self
            navigationView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImageView.do {
            $0.backgroundColor = .hpGray2
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constant.imageHeight / 2
            $0.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewDidTap))
            $0.addGestureRecognizer(gesture)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nicknameLabel.do {
            $0.text = "닉네임"
            $0.font = .largeSemibold
            $0.textColor = .hpBlack
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nicknameTextField.do {
            $0.placeholder = "닉네임을 입력하세요"
            $0.font = .bodyRegular
            $0.textColor = .hpBlack
            $0.borderStyle = .roundedRect
            $0.leftView = .init(frame: .init(origin: .zero, size: .init(width: 5, height: 0)))
            $0.leftViewMode = .always
            $0.rightView = .init(frame: .init(origin: .zero, size: .init(width: 5, height: 0)))
            $0.rightViewMode = .always
            $0.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        signUpButton.do {
            $0.style = .normal
            $0.setTitle("가입하기", for: .normal)
            $0.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
            $0.isEnabled = false
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        
    }
    
}

private extension SignUpViewController {
    
    @objc func profileImageViewDidTap() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func signUpButtonDidTap() {
        listener?.signUpButtonDidTap()
    }
    
    @objc func nicknameTextFieldDidChange() {
        listener?.nicknameDidChange(nicknameTextField.text ?? "")
    }
    
}

extension SignUpViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self)
        else {
            // TODO: Handle empty results or item provider not being able load UIImage
            return
        }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
            DispatchQueue.main.async { [weak self] in
                guard let image = image as? UIImage,
                      let imageData = image.pngData() else { return }
                self?.profileImageView.image = image
                self?.listener?.profileImageViewDidChange(imageData)
            }
        }
    }
    
}

extension SignUpViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.didTapClose()
    }
    
}
