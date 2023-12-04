//
//  UserEditBasicInformationView.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

struct UserInfoEditBasicInformationViewModel {
    let username: String
}

protocol UserInfoEditBasicInformationViewDelegate: AnyObject {
    func usernameValueChanged(_ username: String)
}

final class UserInfoEditBasicInformationView: UIView {
    
    weak var delegate: UserInfoEditBasicInformationViewDelegate?
    
    private enum Constant {
        static let topOffset: CGFloat = 15
        static let bottomOffset: CGFloat = -topOffset
        static let spacing: CGFloat = 20
        
        enum TitleLabel {
            static let title = "기본 정보"
        }
        
        enum UsernameTextField {
            static let placeholder = "닉네임을 입력하세요"
            static let height: CGFloat = 50
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.TitleLabel.title
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constant.UsernameTextField.placeholder
        textField.delegate = self
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.hpGray4.cgColor
        textField.returnKeyType = .done
        textField.clearButtonMode = .always
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.leftViewMode = .always
        textField.leftView = .init(frame: .init(x: 0, y: 0, width: Constant.spacing, height: Constant.UsernameTextField.height))
        textField.addTarget(self, action: #selector(usernameTextFieldValueChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: UserInfoEditBasicInformationViewModel) {
        usernameTextField.text = model.username
    }
    
}


private extension UserInfoEditBasicInformationView {
    
    func setupViews() {
        [titleLabel, usernameTextField].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            usernameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
            usernameTextField.heightAnchor.constraint(equalToConstant: Constant.UsernameTextField.height)
        ])
    }
    
}


private extension UserInfoEditBasicInformationView {
    
    @objc func usernameTextFieldValueChanged(_ sender: UITextField) {
        guard let username = sender.text else { return }
        delegate?.usernameValueChanged(username)
    }
    
}

extension UserInfoEditBasicInformationView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}