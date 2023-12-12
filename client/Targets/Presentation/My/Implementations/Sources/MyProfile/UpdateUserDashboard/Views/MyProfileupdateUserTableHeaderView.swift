//
//  MyPageupdateUserTableHeaderView.swift
//  MyImplementations
//
//  Created by 이준복 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import DomainEntities

protocol MyPageupdateUserTableHeaderViewDelegate: AnyObject {
    func usernameValueChanged(_ username: String)
    func profileImageViewDidTap()
}

final class MyProfileupdateUserTableHeaderView: UITableViewHeaderFooterView {
    weak var delegate: MyPageupdateUserTableHeaderViewDelegate?
    
    private enum Constant {
        static let topOffset: CGFloat = 15
        static let bottomOffset: CGFloat = -topOffset
        enum TitleLabel {
            static let title = "칭호"
        }
    }
    
    private let BadgeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.TitleLabel.title
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myPageUpdateUserProfileView: MyPageUpdateUserProfileView = {
        let contentView = MyPageUpdateUserProfileView()
        contentView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var myPageUpdateUserBasicInformationView: MyProfileUpdateUserBasicInformationView = {
        let contentView = MyProfileUpdateUserBasicInformationView()
        contentView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: ProfileUpdateMetaData) {
        myPageUpdateUserProfileView.setup(profileImageURL: model.profileImageURL)
        myPageUpdateUserBasicInformationView.setup(username: model.username)
    }
    
    func myPageUpdateUserProfileViewSetup(image: UIImage) {
        myPageUpdateUserProfileView.setup(image: image)
    }
    
    func updateAvailableUsernameLabel(_ available: Bool) {
        myPageUpdateUserBasicInformationView.updateAvailableUsernameLabel(available)
    }
    
}

private extension MyProfileupdateUserTableHeaderView {
    
    func setupViews() {
        
        [myPageUpdateUserProfileView, myPageUpdateUserBasicInformationView, BadgeTitleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            myPageUpdateUserProfileView.topAnchor.constraint(equalTo: topAnchor),
            myPageUpdateUserProfileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            myPageUpdateUserProfileView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            
            myPageUpdateUserBasicInformationView.topAnchor.constraint(equalTo: myPageUpdateUserProfileView.bottomAnchor),
            myPageUpdateUserBasicInformationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            myPageUpdateUserBasicInformationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            BadgeTitleLabel.topAnchor.constraint(equalTo: myPageUpdateUserBasicInformationView.bottomAnchor),
            BadgeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            BadgeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            BadgeTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
        ])
    }
    
}

extension MyProfileupdateUserTableHeaderView: MyPageUpdateUserProfileViewDelegate {
    
    func profileImageViewDidTap() {
        delegate?.profileImageViewDidTap()
    }
    
}

extension MyProfileupdateUserTableHeaderView: MyProfileUpdateUserBasicInformationViewDelegate {
    
    func usernameValueChanged(_ username: String) {
        delegate?.usernameValueChanged(username)
    }
    
}
