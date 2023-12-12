//
//  UserProfileUserDashboardViewController.swift
//  MyImplementations
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

protocol UserProfileUserDashboardPresentableListener: AnyObject {
    func followButtonDidTap()
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

final class UserProfileUserDashboardViewController: UIViewController, UserProfileUserDashboardViewControllable, UserProfileUserDashboardPresentable {
    
    weak var listener: UserProfileUserDashboardPresentableListener?
    
    private enum Constant {
        static let spacing: CGFloat = 20
    }

    private let temperatureView = ProfileTemperatureView()
    private let badgeView = ProfileBadgeView()
    private lazy var userView: UserProfileUserView = {
        let userView = UserProfileUserView()
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
    
    func updateFollow(_ isFollow: Bool) {
        userView.updateFollowButton(isFollow)
    }
    
}

extension UserProfileUserDashboardViewController: UserProfileUserViewDelegate {
    
    func followButtonDidTap() {
        listener?.followButtonDidTap()
    }
    
}

private extension UserProfileUserDashboardViewController {
    
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
