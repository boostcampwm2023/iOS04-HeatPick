//
//  HomeFriendContentView.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine
import CoreKit
import DesignKit

struct HomeFriendContentViewModel {
    let userId: Int
    let nickname: String
    let profileImageURL: String?
}

final class HomeFriendContentView: UIView {
    
    var tapPublisher: AnyPublisher<Int, Never> {
        return tapGesturePublisher
            .with(self)
            .compactMap { this, _ in
                this.userId
            }
            .eraseToAnyPublisher()
    }
    
    private var userId: Int?
    
    private enum Constant {
        static let imageWidth: CGFloat = 75
        static let imageHeight: CGFloat = 75
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .hpGray4
        imageView.layer.cornerRadius = Constant.imageHeight / 2
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.textAlignment = .center
        label.font = .captionRegular
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
        profileImageView.cancel()
    }
    
    func setup(model: HomeFriendContentViewModel) {
        if let profileImageURL = model.profileImageURL,
           !profileImageURL.isEmpty {
            profileImageView.load(from: model.profileImageURL)
        } else { profileImageView.image = .profileDefault }
        userId = model.userId
        nicknameLabel.text = model.nickname
    }
    
}

private extension HomeFriendContentView {
    
    func setupViews() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            nicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            nicknameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nicknameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nicknameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
