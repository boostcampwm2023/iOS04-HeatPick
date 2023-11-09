//
//  SignUpViewController.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import UIKit
import PhotosUI

import ModernRIBs

import DesignKit

protocol SignUpPresentableListener: AnyObject {
    var isSignUpEnabled: AnyPublisher<Bool, Never> { get }
    
    func profileImageViewDidChange(_ imageData: Data)
    func signUpButtonDidTap()
    func signUpTextFieldDidEndEditing(_ nickname: String?)
}

final class SignUpViewController: UIViewController, SignUpPresentable, SignUpViewControllable {

    weak var listener: SignUpPresentableListener?
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var profileImageView: UIImageView = {
        let imageView: UIImageView = .init(image: .profileDefault)
        imageView.backgroundColor = .hpGray2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewDidTap))
        imageView.addGestureRecognizer(gesture)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "닉네임"
        label.font = .largeSemibold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let textField: UITextField = .init()
        textField.placeholder = "닉네임을 입력하세요"
        textField.font = .bodyRegular
        textField.textColor = .hpBlack
        textField.borderStyle = .roundedRect
        textField.leftView = .init(frame: .init(origin: .zero, size: .init(width: 5, height: 0)))
        textField.leftViewMode = .always
        textField.rightView = .init(frame: .init(origin: .zero, size: .init(width: 5, height: 0)))
        textField.rightViewMode = .always
        
        textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var signUpButton: ActionButton = {
        let button: ActionButton = .init()
        button.style = .normal
        button.setTitle("가입하기", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
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
    
}

private extension SignUpViewController {
    
    func setupViews() {
        let padding: CGFloat = 30
        let profileImageWidthHeight: CGFloat = 100
        
        view.backgroundColor = .hpWhite
        
        [profileImageView, nicknameLabel, nicknameTextField, signUpButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageWidthHeight),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageWidthHeight),
            
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
        
        profileImageView.layer.cornerRadius = profileImageWidthHeight / 2
    }
    
    func bind() {
        listener?.isSignUpEnabled
            .sink { [weak self] isEnabled in
                self?.signUpButton.isEnabled = isEnabled
            }.store(in: &cancellables)
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        listener?.signUpTextFieldDidEndEditing(textField.text)
    }
    
}

extension SignUpViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async { [weak self] in
                    guard let image = image as? UIImage,
                          let imageData = image.pngData() else { return }
                    
                    self?.profileImageView.image = image
                    self?.listener?.profileImageViewDidChange(imageData)
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
    
}
