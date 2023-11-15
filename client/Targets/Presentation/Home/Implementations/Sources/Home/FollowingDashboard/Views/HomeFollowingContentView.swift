//
//  HomeFollowingContentView.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

struct HomeFollowingContentViewModel {
    let profileModel: HomeFollwoingProfileViewModel
    let thumbnailImageURL: String
    let likes: Int
    let comments: Int
    let title: String
    let subtitle: String
}

final class HomeFollowingContentView: UIView {
        
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .hpGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileView: HomeFollwoingProfileView = {
        let view = HomeFollwoingProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadiusMedium
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let commentView: HomeFollowingCommentView = {
        let view = HomeFollowingCommentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: HomeFollowingContentViewModel) {
        profileView.setup(model: model.profileModel)
        thumbnailImageView.load(from: model.thumbnailImageURL)
        commentView.setup(likes: model.likes, comments: model.comments)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
}

private extension HomeFollowingContentView {
    
    func setupViews() {
        [separator, profileView, thumbnailImageView, commentView, titleLabel, subtitleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            profileView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            profileView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            thumbnailImageView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
            
            commentView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            commentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            
            titleLabel.topAnchor.constraint(equalTo: commentView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
