//
//  SearchMapSearchView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class SearchMapSearchView: UIView {
    
    private enum Constant {
        static let searchImageName = "magnifyingglass"
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: Constant.searchImageName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .hpBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyRegular
        label.textColor = .hpGray2
        label.text = "위치, 장소 검색"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension SearchMapSearchView {
    
    func setupViews() {
        backgroundColor = .hpWhite
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray3.cgColor
        
        [imageView, placeholderLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            placeholderLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
        ])
    }
    
}
