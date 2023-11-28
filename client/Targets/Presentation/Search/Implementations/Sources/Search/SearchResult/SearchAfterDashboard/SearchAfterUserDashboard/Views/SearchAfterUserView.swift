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

final class SearchAfterUserView: UIView {
    
    private enum Constant {
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = -leadingOffset
        
        enum ProfileImageView {
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.ProfileImageView.height / 2
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .hpGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .captionBold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .hpGray1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [nicknameLabel, badgeLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
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
    
    func setup(model: SearchUser) {
        profileImageView.load(from: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg")
        nicknameLabel.text = model.username
        badgeLabel.text = model.username
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
    
}
