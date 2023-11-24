//
//  SearchCurrentLocationStoryListCell.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import BasePresentation
import DesignKit

public struct SearchCurrentLocationStoryListCellModel {
    public let thumbnailImageURL: String
    public let title: String
    public let likes: Int
    public let comments: Int
    public let nickname: String
    public let profileImageURL: String?
    
    public init(thumbnailImageURL: String, title: String, likes: Int, comments: Int, nickname: String, profileImageURL: String?) {
        self.thumbnailImageURL = thumbnailImageURL
        self.title = title
        self.likes = likes
        self.comments = comments
        self.nickname = nickname
        self.profileImageURL = profileImageURL
    }
}

final class SearchCurrentLocationStoryListCell: UITableViewCell {
    
    private enum Constant {
        static let spacing: CGFloat = 20
        static let imageWidth: CGFloat = 350
        static let imageHeight: CGFloat = 180
        static let profileImageWidth: CGFloat = 20
        static let profileImageHeight: CGFloat = 20
    }
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadiusMedium
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storySmallCommentView: StorySmallCommentView = {
       let storySmallCommentView = StorySmallCommentView()
        storySmallCommentView.translatesAutoresizingMaskIntoConstraints = false
        return storySmallCommentView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .hpGray3
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.profileImageWidth / 2
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        titleLabel.text = ""
        storySmallCommentView.setup(likes: 0, comments: 0)
        nicknameLabel.text = ""
        profileImageView.image = nil
    }
    
    deinit {
        thumbnailImageView.cancel()
        profileImageView.cancel()
    }
    
    func setup(model: SearchCurrentLocationStoryListCellModel) {
        thumbnailImageView.load(from: model.thumbnailImageURL)
        titleLabel.text = model.title
        storySmallCommentView.setup(likes: model.likes, comments: model.comments)
        nicknameLabel.text = model.nickname
        profileImageView.load(from: model.profileImageURL)
    }
}

private extension SearchCurrentLocationStoryListCell {
    
    func setupViews() {
        selectionStyle = .none
        
        [thumbnailImageView, storySmallCommentView, titleLabel, profileImageView, nicknameLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.spacing),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            storySmallCommentView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            storySmallCommentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            storySmallCommentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: storySmallCommentView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.spacing),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageHeight),
            
            nicknameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            nicknameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
