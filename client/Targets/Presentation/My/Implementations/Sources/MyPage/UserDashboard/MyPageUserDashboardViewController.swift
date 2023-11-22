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

protocol MyPageUserDashboardPresentableListener: AnyObject {}

final class MyPageUserDashboardViewController: UIViewController, MyPageUserDashboardPresentable, MyPageUserDashboardViewControllable {
    
    private enum Constant {
        static let spacing: CGFloat = 20
    }
    
    weak var listener: MyPageUserDashboardPresentableListener?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userView = MyPageUserView()
    private let temperatureView = MyPageTemperatureView()
    private let badgeView = MyPageBadgeView()
    
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
        titleLabel.text = "호구마츄님 안녕하세요"
        userView.setup(model: .init(
            profileImageURL: nil,
            follower: "10K",
            story: "13",
            experience: "50%"
        ))
        temperatureView.setup(title: "🔥 따뜻해요", temperature: "30℃")
        badgeView.setup(title: "🍼️ 뉴비", content: "저는 아무 것도 모르는 뉴비에요")
    }
    
}

private extension MyPageUserDashboardViewController {
    
    func setupViews() {
        view.addSubview(stackView)
        [titleLabel, userView, temperatureView, badgeView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
