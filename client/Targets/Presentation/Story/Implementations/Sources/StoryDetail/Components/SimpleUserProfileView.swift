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
    
    var image: UIImage? {
        switch self {
        case .me:
            return nil
        case .following:
            return UIImage(systemName: "person.badge.minus")
        case .nonFollowing:
            return UIImage(systemName: "person.badge.plus")
        }
    }
    
}

protocol SimpleUserProfileViewDelegate: AnyObject {
    func followButtonDidTap(userId: Int, userStatus: UserStatus)
}

final class SimpleUserProfileView: UIView {
    
    weak var delegate: SimpleUserProfileViewDelegate?
    
    private let padding: CGFloat = 10
    private let titlePadding: CGFloat = 2
    private var userId: Int?
    private var userStatus: UserStatus = .me {
        didSet {
            followButton.image = userStatus.image
        }
    }
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = padding
        stackView.alignment = .center
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = titlePadding
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
    
    private lazy var followButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = userStatus.image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .hpBlack
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(followButtonDidTap))
        imageView.addGestureRecognizer(gesture)
        
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
    }
    
    func didFollow() {
        userStatus = .following
    }
    
    func didUnfollow() {
        userStatus = .nonFollowing
    }
}

private extension SimpleUserProfileView {
    
    func setupViews() {
        let followButtonWidth: CGFloat = 24
        let followButtonHeight: CGFloat = followButtonWidth
        
        addSubview(userStackView)
        [nicknameLabel, subtitleLabel].forEach(titleStackView.addArrangedSubview)
        [profileImage, titleStackView, followButton].forEach(userStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor, multiplier: 1),
            userStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            userStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            userStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            followButton.widthAnchor.constraint(equalToConstant: followButtonWidth),
            followButton.heightAnchor.constraint(equalToConstant: followButtonHeight)
        ])
    }

}

// MARK: objc
private extension SimpleUserProfileView {
    
    @objc func followButtonDidTap() { 
        guard let userId else { return }
        delegate?.followButtonDidTap(userId: userId, userStatus: userStatus)
    }
    
}
