//
//  MyPageBadgeView.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class MyPageBadgeView: UIView {
    
    private enum Constant {
        static let margin: CGFloat = 20
        static let spacing: CGFloat = 5
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .hpGray1
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
    
    func setup(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
}


private extension MyPageBadgeView {
    
    func setupViews() {
        layer.cornerRadius = Constants.cornerRadiusMedium
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray4.cgColor
        [titleLabel, contentLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.margin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.margin)
        ])
    }
    
}
