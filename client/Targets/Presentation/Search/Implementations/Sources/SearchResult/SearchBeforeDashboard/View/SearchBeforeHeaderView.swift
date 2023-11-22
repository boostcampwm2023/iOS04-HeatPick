//
//  SearchBeforeCollectionHeaderView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class SearchBeforeHeaderView: UICollectionReusableView {
    
    private enum Constant {
        static let topOffset: CGFloat = Constants.leadingOffset
        static let bottomOffset: CGFloat = Constants.traillingOffset
    }
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .largeBold
        label.text = "헤더"
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
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
}

private extension SearchBeforeHeaderView {
    
    func setupViews() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Constant.bottomOffset)
        ])
    }
    
}