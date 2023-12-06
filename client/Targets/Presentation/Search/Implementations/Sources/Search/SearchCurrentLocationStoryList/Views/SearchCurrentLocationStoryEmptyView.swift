//
//  SearchCurrentLocationStoryEmptyView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

final class SearchCurrentLocationStoryEmptyView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
    }
    
    private func setupLayout() {
        [titleLabel, subtitleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupAttributes() {
        titleLabel.do {
            $0.text = "스토리가 없어요"
            $0.font = .bodySemibold
            $0.textColor = .hpBlack
            $0.textAlignment = .center
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        subtitleLabel.do {
            $0.text = "새로운 스토리를 작성해보세요!"
            $0.font = .captionRegular
            $0.textColor = .hpBlack
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
