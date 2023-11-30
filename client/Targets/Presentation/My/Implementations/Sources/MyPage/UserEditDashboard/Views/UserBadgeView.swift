//
//  UserBadgeView.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import CoreKit
import DesignKit

struct UserBadgeViewModel {
    let badgeId: Int
    let badgeName: String
    let emoji: String
    let description: String
}

protocol UserBadgeViewDelegate: AnyObject {
    func didTapUserBadgeView(_ badgeId: Int)
}

final class UserBadgeView: UIView {
    
    weak var delegate: UserBadgeViewDelegate?
    
    private enum Constant {
        static let spacing: CGFloat = 5
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = -topOffset
    }
    
    private var badgeId: Int?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🫡 iOS04"
        label.textColor = .hpBlack
        label.font = .bodySemibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "HeatPick"
        label.textColor = .hpGray1
        label.font = .smallRegular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let nextBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "다음 칭호"
        label.textColor = .hpGray1
        label.font = .smallRegular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextBadgeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "칭호"
        label.textColor = .hpRed3
        label.font = .smallBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.text = "test / 1000"
        label.textColor = .hpGray1
        label.font = .smallBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConfiguration()
    }
    
    func setup(model: UserBadgeViewModel) {
        titleLabel.text = "\(model.emoji) \(model.badgeName)"
        descriptionLabel.text = model.description
    }
    
}


private extension UserBadgeView {
    
    func setupViews() {
        [titleLabel, descriptionLabel, progressView, nextBadgeLabel, nextBadgeTitleLabel, experienceLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constant.spacing),
            progressView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            nextBadgeLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: Constant.spacing),
            nextBadgeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nextBadgeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
            
            nextBadgeTitleLabel.topAnchor.constraint(equalTo: nextBadgeLabel.topAnchor),
            nextBadgeTitleLabel.leadingAnchor.constraint(equalTo: nextBadgeLabel.trailingAnchor, constant: Constant.spacing),
            nextBadgeTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: experienceLabel.leadingAnchor),
            nextBadgeTitleLabel.bottomAnchor.constraint(equalTo: nextBadgeLabel.bottomAnchor),
            
            experienceLabel.topAnchor.constraint(equalTo: nextBadgeLabel.topAnchor),
            experienceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            experienceLabel.bottomAnchor.constraint(equalTo: nextBadgeLabel.bottomAnchor),
        ])
    }
    
    func setupConfiguration() {
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadiusMedium
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray4.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapUserBadgeView))
        addGestureRecognizer(tapGesture)
    }
    
}


private extension UserBadgeView {
    
    @objc func didTapUserBadgeView() {
        guard let badgeId else { return }
        delegate?.didTapUserBadgeView(badgeId)
    }
    
}
