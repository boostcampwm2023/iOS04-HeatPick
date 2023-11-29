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
            refreshImageView.widthAnchor.constraint(equalToConstant: 15),
            refreshImageView.heightAnchor.constraint(equalToConstant: 15),
            refreshImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            refreshImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            refreshImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: refreshImageView.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
}
