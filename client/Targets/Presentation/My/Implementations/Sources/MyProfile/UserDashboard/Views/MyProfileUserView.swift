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
}

struct MyPageUserViewModel {
    let profileImageURL: String?
    let follower: String
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
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
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
    
    private lazy var profileEditButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.tintColor = .hpRed3
        button.configuration?.title = "프로필 수정"
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { transform in
            var transform = transform
            transform.font = .captionBold
            return transform
        }
        button.addTarget(self, action: #selector(profileEditButtonDidTap), for: .touchUpInside)
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
    
    private let experienceView: ProfileUserContnetView = {
        let view = ProfileUserContnetView()
        view.updateTitle("📈 경험치")
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
        storyView.updateContent(model.story)
        experienceView.updateContent(model.experience)
    }
    
}

private extension MyProfileUserView {
    
    @objc func profileEditButtonDidTap() {
        delegate?.profileEditButtonDidTap()
    }
    
}

private extension MyProfileUserView {
    
    func setupViews() {
        [profileImageView, containerContentStackView].forEach(addSubview)
        [followerView, storyView, experienceView].forEach(contentStackView.addArrangedSubview)
        [contentStackView, profileEditButton].forEach(containerContentStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageViewHeight),
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerContentStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            containerContentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
