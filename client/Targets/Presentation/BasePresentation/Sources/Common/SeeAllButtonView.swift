//
//  SeeAllButtonView.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

open class SeeAllButtonView: UIView {
    
    private enum Constant {
        static let title = "모두 보기"
        static let imageWidth: CGFloat = 15
        static let imageHeight: CGFloat = imageWidth
        static let imageName = "chevron.right"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.title
        label.textColor = .hpGray1
        label.font = .captionRegular
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension SeeAllButtonView {
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            arrowImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor)
        ])
    }
    
}
