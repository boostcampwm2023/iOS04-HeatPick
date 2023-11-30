//
//  CommentInputField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

class CommentInputField: UIView {

    private enum Constant {
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = -leadingOffset
        static let topOffset: CGFloat = 5
        static let bottomOffset: CGFloat = -topOffset
        
        static let spacing: CGFloat = 10
        static let minimumCommentTextHeight: CGFloat = 40
        static let maximumCommentTextHeight: CGFloat = 100
        static let commentImageHieght: CGFloat = 40
        static let commentImageWidth: CGFloat = commentImageHieght
    }
    
    private let commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .captionRegular
        textView.textColor = .hpBlack
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byCharWrapping
        textView.isUserInteractionEnabled = true
        textView.textContainerInset = .init(top: 10, left: 15,
                                            bottom: 10, right: 15)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "paperplane.circle.fill")
        imageView.tintColor = .hpBlack
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

private extension CommentInputField {
    
    func setupViews() {
        [commentTextView, commentImageView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingOffset),
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
            
            commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            commentImageView.leadingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: Constant.spacing),
            commentImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.trailingOffset),
            commentImageView.heightAnchor.constraint(equalToConstant: Constant.commentImageHieght),
            commentImageView.widthAnchor.constraint(equalToConstant: Constant.commentImageWidth)
        ])
        
        commentTextView.layer.cornerRadius = Constants.cornerRadiusMedium
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.hpGray4.cgColor
    }
}
