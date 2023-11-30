//
//  CommentTableViewCell.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import DomainEntities

struct CommentTableViewCellModel {
    let userId: Int
    let profileImageUrl: String
    let username: String
    let userStatus: UserStatus
    let date: Date
    let content: String
}

final class CommentTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = -topOffset
        
        static let profileImageHeight: CGFloat = 40
        static let profileImageWidth: CGFloat = Constant.profileImageHeight
        static let profileSpacing: CGFloat = 10
        static let profilePadding: CGFloat = 2
        static let contentSpacing: CGFloat = 10
        static let mentionImageHieght: CGFloat = 24
        static let mentionImageWidth: CGFloat = Constant.mentionImageHieght
    }
    private let dateFormat: Date.FormatStyle = Date.FormatStyle()
                                                    .year(.defaultDigits)
                                                    .month(.abbreviated)
                                                    .day(.twoDigits)
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .profileDefault
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSemibold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .hpGray1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mentionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "bubble")
        imageView.tintColor = .hpBlack
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .bodyRegular
        textView.textColor = .hpBlack
        textView.isScrollEnabled = false
        textView.textContainer.lineBreakMode = .byCharWrapping
        textView.isUserInteractionEnabled = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.cancel()
        profileImageView.image = .profileDefault
    }

    func setup(_ model: CommentTableViewCellModel) {
        profileImageView.load(from: model.profileImageUrl)
        usernameLabel.text = model.username
        dateLabel.text = model.date.formatted(dateFormat)
        contentTextView.text = model.content
    }
    
}

private extension CommentTableViewCell {
    
    func setupViews() {
        [profileImageView, usernameLabel, dateLabel, contentTextView, mentionImageView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageHeight),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageWidth),

            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constant.profileSpacing),
            usernameLabel.bottomAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -Constant.profilePadding),
            
            dateLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constant.profileSpacing),
            dateLabel.topAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: Constant.profilePadding),
            
            mentionImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            mentionImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mentionImageView.heightAnchor.constraint(equalToConstant: Constant.mentionImageHieght),
            mentionImageView.widthAnchor.constraint(equalToConstant: Constant.mentionImageWidth),
            
            contentTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Constant.contentSpacing),
            contentTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset)
        ])
        
        profileImageView.layer.cornerRadius = Constant.profileImageHeight / 2
    }
    
}
