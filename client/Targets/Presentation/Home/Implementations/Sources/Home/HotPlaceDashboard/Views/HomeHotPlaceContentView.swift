//
//  HomeHotPlaceContentView.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

struct HomeHotPlaceContentViewModel {
    let id: Int
    let thumbnailImageURL: String
    let title: String
    let nickname: String
    let profileImageURL: String?
}

final class HomeHotPlaceContentView: UIView {
    
    var id: Int?
    
    private enum Constant {
        static let imageWidth: CGFloat = 180
        static let imageHeight: CGFloat = 180
        static let profileImageWidth: CGFloat = 20
        static let profileImageHeight: CGFloat = 20
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .hpGray4
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadiusMedium
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .hpGray3
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.profileImageWidth / 2
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
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
    
    deinit {
        imageView.cancel()
        profileImageView.cancel()
    }
    
    
    func setup(model: HomeHotPlaceContentViewModel) {
        id = model.id
        titleLabel.text = model.title
        nicknameLabel.text = model.nickname
        imageView.load(from: model.thumbnailImageURL)
        profileImageView.load(from: model.profileImageURL)
    }
    
}

private extension HomeHotPlaceContentView {
    
    func setupViews() {
        [imageView, titleLabel, profileImageView, nicknameLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.profileImageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.profileImageHeight),
            
            nicknameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            nicknameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
