//
//  UserProfileUserView.swift
//  MyImplementations
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

protocol UserProfileUserViewDelegate: AnyObject {
    func followButtonDidTap()
    func followerDidTap()
    func followingDidTap()
}

struct UserProfileUserViewModel {
    let profileImageURL: String?
    let follower: String
    let following: String
    let isFollow: Bool
    let story: String
    let experience: String
}

final class UserProfileUserView: UIView {
    
    weak var delegate: UserProfileUserViewDelegate?
    
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
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.Stack.spacing
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.Stack.spacing
        stackView.distribution = .equalSpacing
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
    
    private lazy var followButton: ActionButton = {
        let button = ActionButton()
        button.setTitle(Constant.FollowButton.unFollow, for: .normal)
        button.layer.borderColor = UIColor.hpBlack.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        button.addTarget(self, action: #selector(followButtonDidTap), for: .touchUpInside)
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
    
    func setup(model: UserProfileUserViewModel) {
        if let profileImageURL = model.profileImageURL,
           !profileImageURL.isEmpty {
            profileImageView.load(from: model.profileImageURL)
        } else { profileImageView.image = .profileDefault }
        
        updateFollowButton(model.isFollow)
        followerView.updateContent(model.follower)
        followingView.updateContent(model.following)
        storyView.updateContent(model.story)
    }
    
    func updateFollowButton(_ isFollow: Bool) {
        isFollow ? updateFollowing() : updateUnFollow()
        followButton.stopLoading()
    }
    
}

private extension UserProfileUserView {
    
    @objc func followButtonDidTap() {
        delegate?.followButtonDidTap()
        followButton.startLoading()
    }
    
    @objc func followerDidTap(){
        delegate?.followerDidTap()
    }
    
    @objc func followingDidTap() {
        delegate?.followingDidTap()
    }

}

private extension UserProfileUserView {
    
    func setupViews() {
        [profileStackView, contentStackView].forEach(addSubview)
        [profileImageView, followButton].forEach(profileStackView.addArrangedSubview)
        [followerView, followingView, storyView].forEach(contentStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageViewHeight),
            profileStackView.topAnchor.constraint(equalTo: topAnchor),
            profileStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.leadingAnchor.constraint(equalTo: profileStackView.trailingAnchor, constant: Constants.leadingOffset),
            contentStackView.centerYAnchor.constraint(equalTo: profileStackView.centerYAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func updateUnFollow() {
        followButton.setTitle(Constant.FollowButton.unFollow, for: .normal)
        followButton.style = .normal
    }
    
    private func updateFollowing() {
        followButton.setTitle(Constant.FollowButton.following, for: .normal)
        followButton.style = .secondary
    }
    
}

