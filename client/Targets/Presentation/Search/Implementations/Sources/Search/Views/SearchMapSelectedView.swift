//
//  SearchMapSelectedView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

protocol SearchMapSelectedViewDelegate: AnyObject {
    func searchMapSelectedViewDidTapCreate(_ view: SearchMapSelectedView)
}

final class SearchMapSelectedView: UIView {
    
    weak var delegate: SearchMapSelectedViewDelegate?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .hpBlack
        label.text = "선택된 장소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createButton: ActionButton = {
        let button = ActionButton()
        button.style = .smallNormal
        button.setTitle("작성하기", for: .normal)
        button.addTarget(self, action: #selector(createButtonDidTap), for: .touchUpInside)
        button.layer.cornerRadius = Constants.cornerRadiusSmall
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
}

private extension SearchMapSelectedView {
    
    func setupViews() {
        backgroundColor = .hpWhite
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray3.cgColor
        layer.cornerRadius = Constants.cornerRadiusMedium
        
        [headerLabel, titleLabel, createButton].forEach(addSubview)
        
        let offset: CGFloat = 20
        NSLayoutConstraint.activate([
            createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            createButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 70),
            createButton.heightAnchor.constraint(equalToConstant: 30),
            
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            
            titleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 3),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            titleLabel.trailingAnchor.constraint(equalTo: createButton.leadingAnchor, constant: -offset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset)
        ])
    }
    
    @objc func createButtonDidTap() {
        delegate?.searchMapSelectedViewDidTapCreate(self)
    }
    
}
