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

struct SearchCurrentLocationStoryListCellModel {
    let thumbnailImageURL: String
    let title: String
    let content: String
    let likes: Int
    let comments: Int
    
    init(thumbnailImageURL: String, title: String, content: String, likes: Int, comments: Int) {
        self.thumbnailImageURL = thumbnailImageURL
        self.title = title
        self.content = content
        self.likes = likes
        self.comments = comments
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
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storySmallCommentView: StorySmallCommentView = {
       let storySmallCommentView = StorySmallCommentView()
        storySmallCommentView.translatesAutoresizingMaskIntoConstraints = false
        return storySmallCommentView
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
    }
    
    deinit {
        thumbnailImageView.cancel()
    }
    
    func setup(model: SearchCurrentLocationStoryListCellModel) {
        thumbnailImageView.load(from: model.thumbnailImageURL)
        titleLabel.text = model.title
        contentLabel.text = model.content
        storySmallCommentView.setup(likes: model.likes, comments: model.comments)
    }
}

private extension SearchCurrentLocationStoryListCell {
    
    func setupViews() {
        selectionStyle = .none
        
        [thumbnailImageView, storySmallCommentView, titleLabel, contentLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.spacing),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            storySmallCommentView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            storySmallCommentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storySmallCommentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: storySmallCommentView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.spacing),
        ])
    }
    
}
