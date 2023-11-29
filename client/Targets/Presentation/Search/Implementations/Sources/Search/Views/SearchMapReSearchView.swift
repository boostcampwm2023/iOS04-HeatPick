//
//  SearchMapReSearchView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class SearchMapReSearchView: UIView {
    
    private enum Constant {
        static let imageWidth: CGFloat = 15
        static let imageHeight: CGFloat = 15
        static let offset: CGFloat = 10
        static let spacing: CGFloat = 5
    }
    
    private let refreshImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.clockwise")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .hpBlue1
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSemibold
        label.textColor = .hpBlue1
        label.textAlignment = .center
        label.text = "현재 위치에서 재검색"
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
    
}

private extension SearchMapReSearchView {
    
    func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadiusMedium
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpBlue2.cgColor
        
        [refreshImageView, titleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            refreshImageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            refreshImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            refreshImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.offset),
            refreshImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.offset),
            refreshImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.offset),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: refreshImageView.trailingAnchor, constant: Constant.spacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.spacing - Constant.offset)
        ])
    }
    
}
