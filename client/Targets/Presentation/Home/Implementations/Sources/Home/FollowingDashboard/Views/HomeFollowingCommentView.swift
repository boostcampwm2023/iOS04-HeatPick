//
//  HomeFollowingCommentView.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class HomeFollowingCommentView: UIView {
    
    private enum Constant {
        static let likeImageName = "heart"
        static let commentImageName = "message"
        static let imageWidth: CGFloat = 15
        static let imageHeight: CGFloat = 15
    }
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constant.likeImageName)
        imageView.tintColor = .hpBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.font = .smallSemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constant.commentImageName)
        imageView.tintColor = .hpBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .smallSemibold
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
    
    func setup(likes: Int, comments: Int) {
        likeLabel.text = "\(likes)"
        commentLabel.text = "\(comments)"
    }
    
}

private extension HomeFollowingCommentView {
    
    func setupViews() {
        [likeImageView, likeLabel, commentImageView, commentLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            likeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            likeImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            likeImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            likeLabel.topAnchor.constraint(equalTo: topAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 1),
            likeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            commentImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            commentImageView.leadingAnchor.constraint(equalTo: likeLabel.trailingAnchor, constant: 10),
            commentImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            commentImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            commentLabel.topAnchor.constraint(equalTo: topAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 1),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
