//
//  SearchAfterUserView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import DomainEntities

protocol SearchAfterUserViewDelegate: AnyObject {
    func didTapUser(userId: Int)
}

final class SearchAfterUserView: UIView {
    
    private enum Constant {
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = -leadingOffset
        
        enum ProfileImageView {
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
    
    weak var delegate: SearchAfterUserViewDelegate?
    
    private var userId: Int?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.ProfileImageView.height / 2
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .hpGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nicknameLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfiguration()
        setupViews()
    }
    
    func setup(model: SearchUser) {
        userId = model.userId
        profileImageView.load(from: model.profileUrl)
        nicknameLabel.text = model.username
    }
    
}

private extension SearchAfterUserView {
    
    func setupViews() {
        [profileImageView, stackView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.ProfileImageView.height),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.ProfileImageView.width),
            
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constant.leadingOffset),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: Constant.trailingOffset)
        ])
    }
    
    
    func setupConfiguration() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(searchAfterUserViewDidTap)
        )
        addGestureRecognizer(tapGesture)
    }
    
}

private extension SearchAfterUserView {
    
    @objc func searchAfterUserViewDidTap() {
        guard let userId else { return }
        delegate?.didTapUser(userId: userId)
    }
    
}
