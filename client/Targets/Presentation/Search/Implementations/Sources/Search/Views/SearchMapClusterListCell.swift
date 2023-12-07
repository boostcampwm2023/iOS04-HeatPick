//
//  SearchMapClusterListCell.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import BasePresentation

struct SearchMapClusterListCellModel {
    let storyId: Int
    let title: String
    let contnet: String
    let likes: Int
    let comments: Int
    let thumbnailUrl: String?
}

final class SearchMapClusterListCell: UITableViewCell {
    
    private let thumbnailView = UIImageView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let commentView = StorySmallCommentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    deinit {
        clear()
    }
    
    func clear() {
        thumbnailView.cancel()
        thumbnailView.image = nil
        titleLabel.text = nil
        contentLabel.text = nil
        commentView.setup(likes: 0, comments: 0)
    }
    
    func setup(model: SearchMapClusterListCellModel) {
        thumbnailView.load(from: model.thumbnailUrl)
        titleLabel.text = model.title
        contentLabel.text = model.contnet
        commentView.setup(likes: model.likes, comments: model.comments)
    }
    
}

private extension SearchMapClusterListCell {
    
    func setupLayout() {
        [thumbnailView, stackView].forEach(contentView.addSubview)
        [titleLabel, contentLabel, commentView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            thumbnailView.heightAnchor.constraint(equalToConstant: Constants.imageWidthSmall),
            thumbnailView.widthAnchor.constraint(equalToConstant: Constants.imageWidthSmall),
            thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
            thumbnailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            stackView.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.traillingOffset),
            stackView.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor)
        ])
    }
    
    func setupAttributes() {
        selectionStyle = .none
        
        thumbnailView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
            $0.contentMode = .scaleAspectFill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .leading
            $0.distribution = .equalSpacing
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do {
            $0.font = .bodyBold
            $0.textColor = .hpBlack
            $0.numberOfLines = 1
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentLabel.do {
            $0.font = .captionRegular
            $0.textColor = .hpBlack
            $0.numberOfLines = 1
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
