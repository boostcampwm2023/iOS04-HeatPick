//
//  SimpleUserProfileView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import CoreKit
import DesignKit
import DomainEntities

struct SimpleUserProfileViewModel {
    
    let id: Int
    let nickname: String
    let subtitle: String
    let profileImageUrl: String?
    let userStatus: UserStatus
    
    init(id: Int, nickname: String, subtitle: String, profileImageUrl: String?, userStatus: UserStatus) {
        self.id = id
        self.nickname = nickname
        self.subtitle = subtitle
        self.profileImageUrl = profileImageUrl
        self.userStatus = userStatus
    }
    
}

fileprivate extension UserStatus {
    
    var buttonConfiguration: UIButton.Configuration? {
        switch self {
        case .me:
            return nil
            
        case .following:
            var config = UIButton.Configuration.filled()
            config.cornerStyle = .capsule
            config.background.backgroundColor = .hpWhite
            
            var container = AttributeContainer()
            container.font = .smallSemibold
            container.foregroundColor = .hpBlack
            config.attributedTitle = AttributedString("언팔로우", attributes: container)
            config.contentInsets = .init(top: 8, leading: 10, bottom: 8, trailing: 10)
            
            return config
            
        case .nonFollowing:
            var config = UIButton.Configuration.filled()
            config.cornerStyle = .capsule
            config.background.backgroundColor = .hpBlack
            
            var container = AttributeContainer()
            container.font = .smallSemibold
            container.foregroundColor = .hpWhite
            config.attributedTitle = AttributedString("팔로우", attributes: container)
            config.contentInsets = .init(top: 8, leading: 10, bottom: 8, trailing: 10)
            
            return config
        }
    }
    
}

protocol SimpleUserProfileViewDelegate: AnyObject {
    func profileDidTap(userId: Int)
    func followButtonDidTap(userId: Int, userStatus: UserStatus)
}

final class SimpleUserProfileView: UIView {
    
    weak var delegate: SimpleUserProfileViewDelegate?
    
    private enum Constant {
        static let padding: CGFloat = 10
        static let titlePadding: CGFloat = 2
        static let followButtonHeight: CGFloat = 32
    }
    
    private var userId: Int?
    private var userStatus: UserStatus = .nonFollowing {
        didSet {
            followButton.configuration = userStatus.buttonConfiguration
        }
    }
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.padding
        stackView.alignment = .center
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.contentMode = .scaleAspectFill
        imageView.addTapGesture(target: self, action: #selector(profileDidTap))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.titlePadding
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSemibold
        label.textColor = .hpBlack
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .hpGray1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.configuration = userStatus.buttonConfiguration
        button.addTapGesture(target: self, action: #selector(followButtonDidTap))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layer.cornerRadius = 20
        profileImage.layer.masksToBounds = true
    }
    
    func setup(model: SimpleUserProfileViewModel) {
        nicknameLabel.text = model.nickname
        subtitleLabel.text = model.subtitle
        profileImage.load(from: model.profileImageUrl)
        userId = model.id
        userStatus = model.userStatus
        setupFollowButton()
    }
    
    func didFollow() {
        userStatus = .following
        followButton.isEnabled = true
    }
    
    func didUnfollow() {
        userStatus = .nonFollowing
        followButton.isEnabled = true
    }
}

private extension SimpleUserProfileView {
    
    func setupViews() {
        addSubview(userStackView)
        [nicknameLabel, subtitleLabel].forEach(titleStackView.addArrangedSubview)
        [profileImage, titleStackView, followButton].forEach(userStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor, multiplier: 1),
            userStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            userStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            userStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func setupFollowButton() {
        switch userStatus {
        case .me:
            return
        case .following, .nonFollowing:
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.hpBlack.cgColor
            followButton.layer.cornerRadius = Constant.followButtonHeight / 2
        }
    }
}

// MARK: objc
private extension SimpleUserProfileView {
    
    @objc func profileDidTap() {
        guard let userId, .me != userStatus else { return }
        delegate?.profileDidTap(userId: userId)
    }
    
    @objc func followButtonDidTap() {
        guard let userId else { return }
        followButton.isEnabled = false
        delegate?.followButtonDidTap(userId: userId, userStatus: userStatus)
    }
    
}
