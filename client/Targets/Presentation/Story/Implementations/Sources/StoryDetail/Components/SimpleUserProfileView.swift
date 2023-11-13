//
//  SimpleUserProfileView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import UIKit

import ModernRIBs

import CoreKit
import DesignKit

struct SimpleUserProfileViewModel {
    
    let nickname: String
    let subtitle: String
    let profileImageUrl: String?
    let userStatus: UserStatus
    
    init(nickname: String, subtitle: String, profileImageUrl: String?, userStatus: UserStatus) {
        self.nickname = nickname
        self.subtitle = subtitle
        self.profileImageUrl = profileImageUrl
        self.userStatus = userStatus
    }
    
}

extension UserStatus {
    var image: UIImage? {
        switch self {
        case .selfUser:
            return nil
        case .followingUser:
            return UIImage(systemName: "person.badge.minus")
        case .nonFollowingUser:
            return UIImage(systemName: "person.badge.plus")
        }
    }
}

final class SimpleUserProfileView: UIView {
    
    private var listener: StoryDetailPresentableListener?
    private var cancellables = Set<AnyCancellable>()
    
    private let padding: CGFloat = 10
    private let titlePadding: CGFloat = 2
    
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
        imageView.contentMode = .scaleAspectFit
        
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
        imageView.image = UserStatus.nonFollowingUser.image
        imageView.contentMode = .scaleAspectFit
        
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
    
    convenience init(listener: StoryDetailPresentableListener?) {
        self.init()
        self.listener = listener
        setupViews()
    }
    
    func setup(model: SimpleUserProfileViewModel) {
        nicknameLabel.text = model.nickname
        subtitleLabel.text = model.subtitle
        
        profileImage.load(from: model.profileImageUrl)
    }
    
}

private extension SimpleUserProfileView {
    
    func setupViews() {
        addSubview(userStackView)
        [nicknameLabel, subtitleLabel].forEach(titleStackView.addArrangedSubview)
        [profileImage, titleStackView, followButton].forEach(userStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            userStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            userStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            userStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
    }
    
//    TODO: bind following button
//    func bind() {
//        listener?.userStatus
//            .sink { status in
//                status.image
//            }.store(in: &cancellables)
//    }
}
