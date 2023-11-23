//
//  UserBadgeView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

final class UserBadgeView: UIView {

    enum Constant {
        static let leadingTrailingPadding: CGFloat = 15
        static let topBottomPadding: CGFloat = 7
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = .smallSemibold
        label.textColor = .hpBlack
        
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
    
    func setBadge(_ badge: String) {
        label.text = badge
        
        guard !badge.isEmpty else {
            return
        }
        
        layer.cornerRadius = Constants.cornerRadiusMedium
        layer.borderColor = UIColor.hpBlack.cgColor
        layer.borderWidth = 1
    }
    
    private func setupViews() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingTrailingPadding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.leadingTrailingPadding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topBottomPadding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.topBottomPadding)
        ])
    }
    
}
