//
//  StoryLikesCommentsView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import UIKit

final class StoryLikesCommentsView: UIView {
       
    private lazy var likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .hpBlack
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .hpBlack
         
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.textAlignment = .center
        
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
    
}

private extension StoryLikesCommentsView {
    
    func setupViews() {
        let spacing: CGFloat = 3
        let padding: CGFloat = 10
        
        [likesImage, likesCountLabel, commentsImage, commentsCountLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            likesImage.topAnchor.constraint(equalTo: topAnchor),
            likesImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            likesImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            likesImage.widthAnchor.constraint(equalTo: likesImage.heightAnchor, multiplier: 1),
            
            likesCountLabel.topAnchor.constraint(equalTo: topAnchor),
            likesCountLabel.leadingAnchor.constraint(equalTo: likesImage.trailingAnchor, constant: spacing),
            likesCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            commentsImage.topAnchor.constraint(equalTo: topAnchor),
            commentsImage.leadingAnchor.constraint(equalTo: likesCountLabel.trailingAnchor, constant: padding),
            commentsImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentsImage.widthAnchor.constraint(equalTo: commentsImage.heightAnchor, multiplier: 1),
            
            commentsCountLabel.topAnchor.constraint(equalTo: topAnchor),
            commentsCountLabel.leadingAnchor.constraint(equalTo: commentsImage.trailingAnchor, constant: spacing),
            commentsCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentsCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
