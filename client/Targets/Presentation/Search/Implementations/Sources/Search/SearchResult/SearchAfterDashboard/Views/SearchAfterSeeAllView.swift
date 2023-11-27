//
//  SearchAfterSeeAllView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class SearchAfterSeeAllView: UIView {
    
    private enum Constant {
        static let title = "모두 보기"
        static let imageConstant: CGFloat = 15
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
    
    private let imageView: UIImageView = {
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
    
}

private extension SearchAfterSeeAllView {
    
    func setupViews() {
        [titleLabel, imageView].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageConstant),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageConstant),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
    
}
