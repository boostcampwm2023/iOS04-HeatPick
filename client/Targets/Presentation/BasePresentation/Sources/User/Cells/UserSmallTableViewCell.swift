//
//  UserSmallTableViewCell.swift
//  BasePresentation
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

public struct UserSmallTableViewCellModel {
    
    public let userId: Int
    public let username: String
    public let profileUrl: String
    
    public init(userId: Int, username: String, profileUrl: String) {
        self.userId = userId
        self.username = username
        self.profileUrl = profileUrl
    }
    
}

public final class UserSmallTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let spacing: CGFloat = 10
        
        enum ProfileImageView {
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .profileDefault
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.ProfileImageView.height / 2
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .hpGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    public func setup(model: UserSmallTableViewCellModel) {
        profileImageView.load(from: model.profileUrl)
        nicknameLabel.text = model.username
    }
    
}

private extension UserSmallTableViewCell {
    
    func setupViews() {
        selectionStyle = .none
        backgroundColor = .hpWhite
        [profileImageView, nicknameLabel].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.ProfileImageView.height),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.ProfileImageView.width),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constant.spacing),
            nicknameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nicknameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: Constants.traillingOffset)
        ])
    }
    
    func reset() {
        profileImageView.cancel()
        profileImageView.image = nil
        nicknameLabel.text = nil
    }
    
}
