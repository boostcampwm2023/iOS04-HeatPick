//
//  SearchBeforeCategoryDashboardCell.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

struct SearchBeforeCategoryDashboardCellModel: Decodable {
    let title: String
    let description: String
}

final class SearchBeforeCategoryDashboardCell: UITableViewCell {
    
    private enum Constant {
        static let spacing: CGFloat = 6
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -topOffset
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.text = "카테고리"
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .captionBold
        label.text = "내용"
        label.numberOfLines = 0
        label.textColor = .hpGray1
        label.setContentHuggingPriority(.init(200), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func setup(_ model: SearchBeforeCategoryDashboardCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
}

private extension SearchBeforeCategoryDashboardCell {

    func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadiusMedium
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        [titleLabel, descriptionLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: Constant.bottomOffset),
        ])
    }
    
    func reset() {
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
}
