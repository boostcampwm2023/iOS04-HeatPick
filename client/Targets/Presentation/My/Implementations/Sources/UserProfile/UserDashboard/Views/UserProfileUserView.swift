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
}

struct UserProfileUserViewModel {
    let profileImageURL: String?
    let follower: String
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
    
    private lazy var followButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.title = Constant.FollowButton.unFollow
        button.configuration?.baseBackgroundColor = .hpRed3
        button.configuration?.baseForegroundColor = .hpWhite
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { transform in
            var transform = transform
            transform.font = .captionBold
            return transform
        }
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.hpRed3.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        button.addTarget(self, action: #selector(followButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let followerView: ProfileUserContnetView = {
        let view = ProfileUserContnetView()
        view.updateTitle("😀 팔로워")
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
        
        updateFollowButton(model.isFollow)
        followerView.updateContent(model.follower)
        storyView.updateContent(model.story)
    }
    
    func updateFollowButton(_ isFollow: Bool) {
        isFollow ? updateFollowing() : updateUnFollow()
    }
    
}

private extension UserProfileUserView {
    
    @objc func followButtonDidTap() {
        delegate?.followButtonDidTap()
    }
}

private extension UserProfileUserView {
    
    func setupViews() {
        [profileStackView, contentStackView].forEach(addSubview)
        [profileImageView, followButton].forEach(profileStackView.addArrangedSubview)
        [followerView, storyView].forEach(contentStackView.addArrangedSubview)
        
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
        followButton.configuration?.title = Constant.FollowButton.unFollow
        followButton.configuration?.baseBackgroundColor = .hpRed3
        followButton.configuration?.baseForegroundColor = .hpWhite
    }
    
    private func updateFollowing() {
        followButton.configuration?.title = Constant.FollowButton.following
        followButton.configuration?.baseBackgroundColor = .hpWhite
        followButton.configuration?.baseForegroundColor = .hpRed3
    }
    
}

