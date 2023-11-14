//
//  UserBadgeView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class UserBadgeView: UIView {

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
        
        layer.cornerRadius = 15
        layer.borderColor = UIColor.hpBlack.cgColor
        layer.borderWidth = 1
    }
    
    private func setupViews() {
        let leadingTrailingPadding: CGFloat = 15
        let topBottomPadding: CGFloat = 7
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingTrailingPadding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leadingTrailingPadding),
            label.topAnchor.constraint(equalTo: topAnchor, constant: topBottomPadding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomPadding)
        ])
    }
    
}
