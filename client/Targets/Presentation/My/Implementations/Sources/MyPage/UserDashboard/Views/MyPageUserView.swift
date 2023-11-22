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
    func myPageUserViewDidTapProfile(_ view: MyPageUserView)
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
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.addTapGesture(target: self, action: #selector(profileDidTap))
        imageView.layer.cornerRadius = Constant.profileImageViewWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        profileImageView.load(from: model.profileImageURL)
        followerView.updateContent(model.follower)
        storyView.updateContent(model.story)
        experienceView.updateContent(model.experience)
    }
    
}

private extension MyPageUserView {
    
    @objc func profileDidTap() {
        delegate?.myPageUserViewDidTapProfile(self)
    }
    
}

private extension MyPageUserView {
    
    func setupViews() {
        [profileImageView, contentStackView].forEach(addSubview)
        [followerView, storyView, experienceView].forEach(contentStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageViewWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageViewHeight),
            
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
