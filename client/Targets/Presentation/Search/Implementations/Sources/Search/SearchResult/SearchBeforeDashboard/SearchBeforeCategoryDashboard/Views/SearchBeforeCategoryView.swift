//
//  SearchBeforeCategoryView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import DomainEntities

protocol SearchBeforeCategoryViewDelegate: AnyObject {
    func categoryViewDidTap(_ category: SearchCategory)
}

final class SearchBeforeCategoryView: UIView {
    
    weak var delegate: SearchBeforeCategoryViewDelegate?
    
    private enum Constant {
        static let spacing: CGFloat = 6
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -topOffset
    }
    
    private var category: SearchCategory?
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.text = "카테고리"
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.text = "내용"
        label.numberOfLines = 0
        label.textColor = .hpGray1
        label.setContentHuggingPriority(.init(200), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfiguration()
        setupView()
    }
    
    func setup(_ model: SearchCategory) {
        self.category = model
        categoryNameLabel.text = model.categoryName
        descriptionLabel.text = model.categoryContent
    }
    
}

private extension SearchBeforeCategoryView {
    
    func setupView() {
        [categoryNameLabel, descriptionLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            descriptionLabel.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: Constant.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
        ])
    }
    
    func setupConfiguration() {
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadiusMedium
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray3.cgColor
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(categoryViewDidTap)
        )
        addGestureRecognizer(tapGesture)
    }
    
}

private extension SearchBeforeCategoryView {
    
    @objc func categoryViewDidTap() {
        guard let category else { return }
        delegate?.categoryViewDidTap(category)
    }
    
}
