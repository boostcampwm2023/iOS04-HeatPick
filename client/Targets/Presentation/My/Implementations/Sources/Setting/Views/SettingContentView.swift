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
    
}

private extension SettingContentView {
    
    func setupViews() {
        [arrowImageView,titleLabel, subtitleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
