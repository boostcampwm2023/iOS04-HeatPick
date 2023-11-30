//
//  UserEditProfileView.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import CoreKit

struct UserInfoEditProfileViewModel {
    let profileImageURL: String?
}

protocol UserInfoEditProfileViewDelegate: AnyObject {
    func profileImageViewDidTap()
}

final class UserInfoEditProfileView: UIView {
    
    weak var delegate: UserInfoEditProfileViewDelegate?
    
    private enum Constant {
        enum ProfileImage {
            static let length: CGFloat = 100
            static let topOffset: CGFloat = 35
            static let bottomOffset: CGFloat = -15
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.ProfileImage.length / 2
        imageView.addTapGesture(target: self, action: #selector(profileImageViewDidTap))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: UserInfoEditProfileViewModel) {
        profileImageView.load(from: model.profileImageURL)
    }
    
    func setup(image: UIImage) {
        profileImageView.image = image
    }
    
}

private extension UserInfoEditProfileView {
    
    func setupViews() {
        addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.ProfileImage.length),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.ProfileImage.length),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.ProfileImage.topOffset),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.ProfileImage.bottomOffset),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}

private extension UserInfoEditProfileView {
    
    @objc func profileImageViewDidTap() {
        delegate?.profileImageViewDidTap()
    }
    
}

