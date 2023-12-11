//
//  MyPageUpdateUserBadgeCell.swift
//  MyImplementations
//
//  Created by 이준복 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import CoreKit
import DesignKit
import DomainEntities

final class MyProfileUpdateUserBadgeCell: UITableViewCell {
    
    private enum Constant {
        static let spacing: CGFloat = 5
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = -topOffset
        static let maxExp: Float = 1000
    }
        
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
        progressView.tintColor = .hpRed3
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
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hpWhite
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.cornerRadiusMedium
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hpGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConfiguration()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func setup(model: ProfileUpdateMetaDataBadge) {
        titleLabel.text = "\(model.emoji) \(model.badgeName)"
        descriptionLabel.text = model.badgeExplain
        progressView.progress = Float(model.badgeExp) / Constant.maxExp
        experienceLabel.text = "\(model.badgeExp) / \(Int(Constant.maxExp))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        updateUI()
    }
    
}

private extension MyProfileUpdateUserBadgeCell {
    
    func setupViews() {
        contentView.addSubview(containerView)
        [titleLabel, descriptionLabel, progressView, nextBadgeLabel, nextBadgeTitleLabel, experienceLabel].forEach(containerView.addSubview)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.traillingOffset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constant.bottomOffset),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.traillingOffset),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constant.spacing),
            progressView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            nextBadgeLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: Constant.spacing),
            nextBadgeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            nextBadgeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constant.bottomOffset),
            
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
        selectionStyle = .none
    }
    
    func reset() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        progressView.progress = 0
        experienceLabel.text = nil
        isSelected = false
    }
    
    func updateUI() {
        containerView.backgroundColor = isSelected ? .hpRed5 : .hpWhite
        containerView.layer.borderColor = isSelected ? UIColor.hpRed3.cgColor : UIColor.hpGray4.cgColor
    }
    
}
