//
//  MyPageUserContnetView.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class ProfileUserContnetView: UIView {
    
    private enum Constant {
        static let spacing: CGFloat = 5
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .captionSemibold
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .captionBold
        label.textAlignment = .center
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
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func updateContent(_ content: String) {
        contentLabel.text = content
    }
    
}

private extension ProfileUserContnetView {
    
    func setupViews() {
        [titleLabel, contentLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
