//
//  FollowingTitleView.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import DomainEntities

typealias FollowingTitleViewDelegate = FollowingDropDownViewDelegate

final class FollowingTitleView: UIView {
    
    weak var delegate: FollowingTitleViewDelegate? {
        didSet { dropDownView.delegate = self.delegate }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "팔로잉"
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dropDownView: FollowingDropDownView = {
        let dropDownView = FollowingDropDownView()
        dropDownView.setup(options: HomeFollowingSortOption.allCases)
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        return dropDownView
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

private extension FollowingTitleView {
    
    func setupViews() {
        [titleLabel, dropDownView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            dropDownView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dropDownView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: dropDownView.leadingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
