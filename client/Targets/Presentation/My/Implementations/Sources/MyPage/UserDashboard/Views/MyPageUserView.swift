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
    func followButtonDidTap()
}

struct MyPageUserViewModel {
    let profileImageURL: String?
    let follower: String
    let story: String
    let experience: String
}

final class MyPageUserView: UIView {
    
    weak var delegate: MyPageUserViewDelegate?
    
    private enum Constant {
        static let profileImageViewWidth: CGFloat = 100
        static let profileImageViewHeight: CGFloat = 100
    }
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.profileImageViewWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.tintColor = .hpRed3
        button.setTitle("팔로우", for: .normal)
        button.addTarget(self, action: #selector(followButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var profileEditButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.tintColor = .hpRed3
        button.setTitle("프로필 수정", for: .normal)
        button.addTarget(self, action: #selector(profileEditButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let followerView: MyPageUserContnetView = {
        let view = MyPageUserContnetView()
        view.updateTitle("😀 팔로워")
        return view
    }()
    
    private let storyView: MyPageUserContnetView = {
        let view = MyPageUserContnetView()
        view.updateTitle("📕 스토리")
        return view
    }()
    
    private let experienceView: MyPageUserContnetView = {
        let view = MyPageUserContnetView()
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
        } else {
            profileImageView.image = .profileDefault
        }
        followerView.updateContent(model.follower)
        storyView.updateContent(model.story)
        experienceView.updateContent(model.experience)
    }
    
}

private extension MyPageUserView {
    
    @objc func profileEditButtonDidTap() {
        delegate?.profileEditButtonDidTap()
    }
    
    @objc func followButtonDidTap() {
        delegate?.followButtonDidTap()
    }
}

private extension MyPageUserView {
    
    func setupViews() {
        [profileStackView, contentStackView, profileEditButton].forEach(addSubview)
        [profileImageView, followButton].forEach(profileStackView.addArrangedSubview)
        [followerView, storyView, experienceView].forEach(contentStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageViewHeight),
            profileStackView.topAnchor.constraint(equalTo: topAnchor),
            profileStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            profileEditButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            profileEditButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            profileEditButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
