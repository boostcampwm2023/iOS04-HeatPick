//
//  SearchAfterStoryView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import BasePresentation

struct SearchAfterStoryViewModel {
    let stroyId: Int
    let title: String
    let address: String
    let thumbnailImage: String
    let likeCount: Int
    let commentCount: Int
}

final class SearchAfterStoryView: UIView {
    
    private enum Constant {
        enum ImageView {
            static let width: CGFloat = 100
            static let height: CGFloat = 100
        }
        
        enum StackView {
            static let spacing: CGFloat = 5
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadiusMedium
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.text = "제목"
        label.textColor = .hpBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.text = "주소"
        label.textColor = .hpBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentView: StorySmallCommentView = {
        let commentView = StorySmallCommentView()
        commentView.translatesAutoresizingMaskIntoConstraints = false
        return commentView
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLabel, addressLabel, commentView])
        stackView.axis = .vertical
        stackView.spacing = Constant.StackView.spacing
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: SearchAfterStoryViewModel) {
        titleLabel.text = model.title
        imageView.load(from: model.thumbnailImage)
        addressLabel.text = model.address
        commentView.setup(likes: model.likeCount, comments: model.commentCount)
    }
    
}


private extension SearchAfterStoryView {
    
    func setupViews() {
        [imageView, stackView].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constant.ImageView.height),
            imageView.widthAnchor.constraint(equalToConstant: Constant.ImageView.width),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
