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
    func followerDidTap()
    func followingDidTap()
}

struct MyProfileViewControllerModel {
    let userName: String
    let profileImageURL: String?
    let follower: String
    let following: String
    let storyCount: String
    let experience: String
    let temperatureTitle: String
    let temperature: String
    let badgeTitle: String
    let badgeContent: String
}

final class MyPageUserDashboardViewController: UIViewController, MyPageUserDashboardPresentable, MyPageUserDashboardViewControllable {
    
    weak var listener: MyPageUserDashboardPresentableListener?
    
    private enum Constant {
        static let spacing: CGFloat = 20
    }

    private let temperatureView = ProfileTemperatureView()
    private let badgeView = ProfileBadgeView()
    private lazy var userView: MyProfileUserView = {
        let userView = MyProfileUserView()
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
    
    func setup(model: MyProfileViewControllerModel) {
        userView.setup(model: .init(
            profileImageURL: model.profileImageURL,
            follower: model.follower,
            following: model.following,
            isFollow: false,
            story: model.storyCount,
            experience: model.experience
        ))
        temperatureView.setup(title: model.temperatureTitle, temperature: model.temperature)
        badgeView.setup(title: model.badgeTitle, content: model.badgeContent)
    }
    
}


extension MyPageUserDashboardViewController: MyPageUserViewDelegate {
    
    func profileEditButtonDidTap() {
        listener?.profileEditButtonDidTap()
    }
    
    func followerDidTap() {
        listener?.followerDidTap()
    }
    
    func followingDidTap() {
        listener?.followingDidTap()
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
