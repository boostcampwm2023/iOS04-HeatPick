//
//  CommentInputField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

protocol CommentInputFieldDelegate: AnyObject {
    func commentTextDidChange(_ text: String)
    func commentButtonDidTap()
}

final class CommentInputField: UIView {
    
    weak var delegate: CommentInputFieldDelegate?
    private var isButtonEnabled: Bool = false {
        didSet {
            if isButtonEnabled {
                commentImageView.isUserInteractionEnabled = true
                commentImageView.tintColor = .hpBlack
            } else {
                commentImageView.isUserInteractionEnabled = false
                commentImageView.tintColor = .hpGray4
            }
        }
    }
    
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
        
        static let textTopBottomInset: CGFloat = 10
        static let textLeadingTrailingInset: CGFloat = 15
    }
    
    private lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .captionRegular
        textView.textColor = .hpBlack
        textView.isScrollEnabled = true
        textView.textContainer.lineBreakMode = .byCharWrapping
        textView.isUserInteractionEnabled = true
        textView.textContainerInset = .init(top: Constant.textTopBottomInset, left: Constant.textLeadingTrailingInset,
                                            bottom: Constant.textTopBottomInset, right: Constant.textLeadingTrailingInset)
        textView.delegate = self
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .hpGray2
        label.text = "댓글을 입력해주세요"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "paperplane.circle.fill")
        imageView.tintColor = .hpGray4
        imageView.addTapGesture(target: self, action: #selector(commentButtonDidTap))
        
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
    
    func setButton(_ isEnabled: Bool) {
        isButtonEnabled = isEnabled
    }
    
    func clear() {
        isButtonEnabled = false
        commentTextView.text = ""
        placeHolderLabel.isHidden = false
    }
    
    func reset() {
        isButtonEnabled = true
    }
}

private extension CommentInputField {
    
    func setupViews() {
        [commentTextView, commentImageView, placeHolderLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingOffset),
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
            
            commentImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            commentImageView.leadingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: Constant.spacing),
            commentImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.trailingOffset),
            commentImageView.heightAnchor.constraint(equalToConstant: Constant.commentImageHieght),
            commentImageView.widthAnchor.constraint(equalToConstant: Constant.commentImageWidth),
            
            placeHolderLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: Constant.textTopBottomInset),
            placeHolderLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: Constant.textLeadingTrailingInset)
        ])
        
        commentTextView.layer.cornerRadius = Constants.cornerRadiusMedium
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.hpGray4.cgColor
    }
    
    @objc func commentButtonDidTap() {
        commentImageView.isUserInteractionEnabled = false
        commentTextView.resignFirstResponder()
        delegate?.commentButtonDidTap()
    }
    
}

extension CommentInputField: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        delegate?.commentTextDidChange(text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = textView.text, text.isEmpty {
            placeHolderLabel.isHidden = false
        }
    }
}
