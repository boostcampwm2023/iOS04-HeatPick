//
//  StoryHeaderView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

final class StoryHeaderView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBold
        label.textColor = .hpBlack
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView       
    }()
           
    private let userBadgeView: UserBadgeView = {
        let badge = UserBadgeView()
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
    
    private lazy var storyLikesCommentsView: StoryLikesCommentsView = {
        let likesCommentsView = StoryLikesCommentsView()
        
        likesCommentsView.translatesAutoresizingMaskIntoConstraints = false
        return likesCommentsView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension StoryHeaderView {
    func setupViews() {
        addSubview(titleLabel)
        addSubview(stackView)
        [userBadgeView, storyLikesCommentsView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
