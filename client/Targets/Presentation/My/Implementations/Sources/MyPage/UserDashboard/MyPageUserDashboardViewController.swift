//
//  MyPageUserDashboardViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

protocol MyPageUserDashboardPresentableListener: AnyObject {
    func profileEditButtonDidTap()
}

protocol UserProfileUserDashboardPresentableListener: AnyObject {
    func followButtonDidTap()
}

struct MyProfileViewControllerModel {
    let userName: String
    let profileImageURL: String?
    let follower: String
    let storyCount: String
    let experience: String
    let temperatureTitle: String
    let temperature: String
    let badgeTitle: String
    let badgeContent: String
}

struct UserProfileViewControllerModel {
    let userName: String
    let profileImageURL: String?
    let isFollow: Bool
    let follower: String
    let storyCount: String
    let experience: String
    let temperatureTitle: String
    let temperature: String
    let badgeTitle: String
    let badgeContent: String

}

final class MyPageUserDashboardViewController: UIViewController {
    
    weak var myProfileListener: MyPageUserDashboardPresentableListener?
    weak var userProfileListener: UserProfileUserDashboardPresentableListener?
    
    private enum Constant {
        static let spacing: CGFloat = 20
    }

    private let temperatureView = MyPageTemperatureView()
    private let badgeView = MyPageBadgeView()
    private lazy var userView: MyPageUserView = {
        let userView = MyPageUserView()
        userView.delegate = self
        return userView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = Constant.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

extension MyPageUserDashboardViewController: MyPageUserDashboardPresentable, MyPageUserDashboardViewControllable {
    
    func setup(model: MyProfileViewControllerModel) {
        userView.setup(model: .init(
            profileImageURL: model.profileImageURL,
            follower: model.follower,
            isFollow: false,
            story: model.storyCount,
            experience: model.experience
        ))
        temperatureView.setup(title: model.temperatureTitle, temperature: model.temperature)
        badgeView.setup(title: model.badgeTitle, content: model.badgeContent)
    }
    
    func setMyProfile() {
        userView.setMyProfile()
    }
    
}

extension MyPageUserDashboardViewController: UserProfileUserDashboardViewControllable, UserProfileUserDashboardPresentable {
    
    func setup(model: UserProfileViewControllerModel) {
        userView.setup(model: .init(
            profileImageURL: model.profileImageURL,
            follower: model.follower,
            isFollow: model.isFollow,
            story: model.storyCount,
            experience: model.experience
        ))
        temperatureView.setup(title: model.temperatureTitle, temperature: model.temperature)
        badgeView.setup(title: model.badgeTitle, content: model.badgeContent)
    }
    
    func setUserProfile() {
        userView.setUserProfile()
    }
    
    func updateFollow(_ isFollow: Bool) {
        userView.updateFollowButton(isFollow)
    }
    
}

extension MyPageUserDashboardViewController: MyPageUserViewDelegate {
    
    func profileEditButtonDidTap() {
        myProfileListener?.profileEditButtonDidTap()
    }
    
    func followButtonDidTap() {
        userProfileListener?.followButtonDidTap()
    }
    
}

private extension MyPageUserDashboardViewController {
    
    func setupViews() {
        view.addSubview(stackView)
        [userView, temperatureView, badgeView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
