//
//  MyPageUserView.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

protocol MyPageUserViewDelegate: AnyObject {
    func profileEditButtonDidTap()
    func followerDidTap()
    func followingDidTap()
}

struct MyPageUserViewModel {
    let profileImageURL: String?
    let follower: String
    let following: String
    let isFollow: Bool
    let story: String
    let experience: String
}

final class MyProfileUserView: UIView {
    
    weak var delegate: MyPageUserViewDelegate?
    
    private enum Constant {
        static let profileImageViewWidth: CGFloat = 100
        static let profileImageViewHeight: CGFloat = 100
        
        enum Stack {
            static let spacing: CGFloat = 10
        }
        
        enum FollowButton {
            static let unFollow = "팔로우"
            static let following = "팔로잉"
        }
    }
    
    private let containerContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.Stack.spacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.Stack.spacing
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constant.profileImageViewWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var profileEditButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("프로필 수정", for: .normal)
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        button.addTarget(self, action: #selector(profileEditButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var followerView: ProfileUserContnetView = {
        let view = ProfileUserContnetView()
        view.updateTitle("😀 팔로워")
        view.addTapGesture(target: self, action: #selector(followerDidTap))
        return view
    }()
    
    private lazy var followingView: ProfileUserContnetView = {
        let view = ProfileUserContnetView()
        view.updateTitle("😀 팔로잉")
        view.addTapGesture(target: self, action: #selector(followingDidTap))
        return view
    }()
    
    private let storyView: ProfileUserContnetView = {
        let view = ProfileUserContnetView()
        view.updateTitle("📕 스토리")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: MyPageUserViewModel) {
        if let profileImageURL = model.profileImageURL,
           !profileImageURL.isEmpty {
            profileImageView.load(from: model.profileImageURL)
        } else { profileImageView.image = .profileDefault }
        
        followerView.updateContent(model.follower)
        followingView.updateContent(model.following)
        storyView.updateContent(model.story)
    }
    
}

private extension MyProfileUserView {
    
    @objc func profileEditButtonDidTap() {
        delegate?.profileEditButtonDidTap()
    }
    
    @objc func followerDidTap(){
        delegate?.followerDidTap()
    }
    
    @objc func followingDidTap() {
        delegate?.followingDidTap()
    }
    
}

private extension MyProfileUserView {
    
    func setupViews() {
        [profileImageView, containerContentStackView].forEach(addSubview)
        [followerView, followingView, storyView].forEach(contentStackView.addArrangedSubview)
        [contentStackView, profileEditButton].forEach(containerContentStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageViewHeight),
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerContentStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.leadingOffset),
            containerContentStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            containerContentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
