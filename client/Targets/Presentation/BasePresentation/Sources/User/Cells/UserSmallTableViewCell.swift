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
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = -leadingOffset
        
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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        badgeLabel.text = model.username
    }
    
}

private extension UserSmallTableViewCell {
    
    func setupViews() {
        selectionStyle = .none
        backgroundColor = .hpWhite
        [nicknameLabel, badgeLabel].forEach(stackView.addArrangedSubview)
        [profileImageView, stackView].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: Constant.ProfileImageView.height),
            profileImageView.widthAnchor.constraint(equalToConstant: Constant.ProfileImageView.width),
            
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constant.leadingOffset),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: Constant.trailingOffset)
        ])
    }
    
    func reset() {
        profileImageView.cancel()
        profileImageView.image = nil
        nicknameLabel.text = nil
        badgeLabel.text = nil
    }
    
}
