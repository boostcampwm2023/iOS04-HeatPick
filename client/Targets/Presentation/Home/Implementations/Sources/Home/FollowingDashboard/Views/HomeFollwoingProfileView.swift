//
//  HomeFollwoingProfileView.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

struct HomeFollwoingProfileViewModel {
    let profileImageURL: String?
    let nickname: String
}

final class HomeFollwoingProfileView: UIView {
    
    private enum Constant {
        static let profileImageWidth: CGFloat = 40
        static let profileImageHeight: CGFloat = 40
        static let labelLeadingConstant: CGFloat = 10
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.profileImageHeight / 2
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .hpGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSemibold
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
    
    func setup(model: HomeFollwoingProfileViewModel) {
        if let profileImageURL = model.profileImageURL,
           !profileImageURL.isEmpty {
            profileImageView.load(from: model.profileImageURL)
        } else { profileImageView.image = .profileDefault }
        
        profileImageView.load(from: model.profileImageURL)
        nicknameLabel.text = model.nickname
    }
    
}

private extension HomeFollwoingProfileView {
    
    func setupViews() {
        [profileImageView, nicknameLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageHeight),
            
            nicknameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constant.labelLeadingConstant),
            nicknameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
