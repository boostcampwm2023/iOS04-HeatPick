//
//  StoryHeaderView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import CoreKit
import DesignKit
import DomainEntities

struct StoryHeaderViewModel {
    let title: String
    let userStatus: UserStatus
    let badgeName: String
    let likeStatus: Bool
    let likesCount: Int
    let commentsCount: Int
}

protocol StoryHeaderViewDelegate: AnyObject {
    func likeButtonDidTap(state: Bool)
    func commentButtonDidTap()
}

final class StoryHeaderView: UIView {
    
    private enum Constant {
        static let spacing: CGFloat = 10
    }
    
    weak var delegate: StoryHeaderViewDelegate?
    private var isLiked: Bool = false
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBold
        label.textColor = .hpBlack
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
           
    private let userBadgeView: UserBadgeView = {
        let badge = UserBadgeView()
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
    
    private lazy var likeButton: ImageCountButton = {
        let button = ImageCountButton()
        button.setup(type: .like)
        button.addTapGesture(target: self, action: #selector(likeButtonDidTap))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var commentButton: ImageCountButton = {
        let button = ImageCountButton()
        button.setup(type: .comment)
        button.addTapGesture(target: self, action: #selector(commentButtonDidTap))
        
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
    
    func setup(model: StoryHeaderViewModel) {
        titleLabel.text = model.title
        userBadgeView.setBadge(model.badgeName)
        setupLikeButton(author: model.userStatus, likeStatus: model.likeStatus, likeCount: model.likesCount)
        commentButton.setup(count: model.commentsCount)
    }
    
    func didLike(count: Int) {
        isLiked = true
        likeButton.setup(count: count)
        likeButton.isUserInteractionEnabled = true
        likeButton.setup(type: .liked)
    }
    
    func didUnlike(count: Int) {
        isLiked = false
        likeButton.setup(count: count)
        likeButton.isUserInteractionEnabled = true
        likeButton.setup(type: .like)
    }
    
    func didFailToLike() {
        likeButton.isUserInteractionEnabled = true
    }
}

private extension StoryHeaderView {
    
    func setupViews() {
        [titleLabel, userBadgeView, likeButton, commentButton].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            userBadgeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            userBadgeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            userBadgeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            likeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            commentButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: Constant.spacing),
            commentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            commentButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupLikeButton(author: UserStatus, likeStatus: Bool, likeCount: Int) {
        switch author {
        case .me:
            likeButton.isUserInteractionEnabled = false
            likeButton.setup(type: .author)
        case .following, .nonFollowing:
            likeButton.setup(type: (likeStatus ? .liked : .like))
        }
        isLiked = likeStatus
        likeButton.setup(count: likeCount)
    }
}

// MARK: - objc
private extension StoryHeaderView {
    
    @objc func likeButtonDidTap() {
        likeButton.isUserInteractionEnabled = false
        delegate?.likeButtonDidTap(state: isLiked)
    }
    
    @objc func commentButtonDidTap() {
        delegate?.commentButtonDidTap()
    }
}
