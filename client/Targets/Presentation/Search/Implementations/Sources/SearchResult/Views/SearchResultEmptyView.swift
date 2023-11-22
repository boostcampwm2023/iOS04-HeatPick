//
//  SearchResultEmptyView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

struct SearchResultEmptyViewModel {
    let title: String
    let subtitle: String
}

final class SearchResultEmptyView: UIView {
    
    private enum Constant {
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = -topOffset
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = -leadingOffset
        static let spacing: CGFloat = 5
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hpWhite
        view.layer.cornerRadius = Constants.cornerRadiusMedium
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hpGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .bodySemibold
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .captionRegular
        label.numberOfLines = 0
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
    
    func setup(model: SearchResultEmptyViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
}

private extension SearchResultEmptyView {
    
    func setupViews() {
        backgroundColor = .hpWhite
        addSubview(containerView)
        [titleLabel, subtitleLabel].forEach(containerView.addSubview)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constant.trailingOffset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.leadingOffset),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.traillingOffset),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constant.bottomOffset),
        ])
    }
    
}

