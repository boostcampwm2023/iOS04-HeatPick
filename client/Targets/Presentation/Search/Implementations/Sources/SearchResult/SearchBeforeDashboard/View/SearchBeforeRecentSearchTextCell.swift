//
//  SearchBeforeRecentSearchTextCell.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

struct ReceentSearchTextModel: Decodable {
    let text: String
}

final class SearchBeforeRecentSearchTextCell: UICollectionViewCell {
    
    private enum Constant {
        static let topOffset: CGFloat = 5
        static let bottomOffset: CGFloat = -topOffset
        static let leadingOffset: CGFloat = 15
        static let trailingOffset: CGFloat = -leadingOffset
    }
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .bodyRegular
        label.text = "최근 검색어"
        label.textColor = .hpBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    func updateRecentSearchText(_ receentSearchText: ReceentSearchTextModel) {
        titleLabel.text = receentSearchText.text
    }
    
}

private extension SearchBeforeRecentSearchTextCell {
    
    func setupView() {
        contentView.backgroundColor = .hpGray3
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.cornerRadiusSmall
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Constant.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: Constant.trailingOffset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: Constant.bottomOffset),
        ])
    }
    
}
