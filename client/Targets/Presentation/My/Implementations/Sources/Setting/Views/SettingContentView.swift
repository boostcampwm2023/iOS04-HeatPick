//
//  SettingContentView.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class SettingContentView: UIView {
    
    private enum Constant {
        static let imageWidth: CGFloat = 15
        static let imageHeight: CGFloat = imageWidth
        static let imageName = "chevron.right"
        static let spacing: CGFloat = 20
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .captionRegular
        label.textColor = .hpGray1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .hpGray1
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: Constant.imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .hpGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(title: String, subtitle: String? = nil) {
        arrowImageView.isHidden = subtitle != nil
        subtitleLabel.isHidden = subtitle == nil
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    func hideSeparator() {
        topSeparator.isHidden = true
    }
    
}

private extension SettingContentView {
    
    func setupViews() {
        [topSeparator, arrowImageView,titleLabel, subtitleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.spacing)
        ])
    }
    
}
