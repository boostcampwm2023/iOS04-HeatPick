//
//  StorySmallTableViewCell.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

public struct StorySmallTableViewCellModel {
    
    public let thumbnailImageURL: String
    public let title: String
    public let subtitle: String
    public let likes: Int
    public let comments: Int
    
    public init(thumbnailImageURL: String, title: String, subtitle: String, likes: Int, comments: Int) {
        self.thumbnailImageURL = thumbnailImageURL
        self.title = title
        self.subtitle = subtitle
        self.likes = likes
        self.comments = comments
    }
    
}

public final class StorySmallTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 100
        static let itemSpacing: CGFloat = 5
        static let bottomInset: CGFloat = 20
    }
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadiusMedium
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = Constant.itemSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .bodySemibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .captionRegular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentView: StorySmallCommentView = {
        let view = StorySmallCommentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        thumbnailImageView.cancel()
    }
    
    public func setup(model: StorySmallTableViewCellModel) {
        thumbnailImageView.load(from: model.thumbnailImageURL)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        commentView.setup(likes: model.likes, comments: model.comments)
    }
    
}

private extension StorySmallTableViewCell {
    
    func setupViews() {
        selectionStyle = .none
        backgroundColor = .hpWhite
        
        [thumbnailImageView, stackView].forEach(contentView.addSubview)
        [titleLabel, subtitleLabel, commentView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.bottomInset),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            stackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.traillingOffset)
        ])
    }
    
}
