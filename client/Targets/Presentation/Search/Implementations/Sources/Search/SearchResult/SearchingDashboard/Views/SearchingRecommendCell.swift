//
//  SearchingRecommendCell.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

struct SearchingRecommendCellModel {
    let recommendText: String
}

final class SearchingRecommendCell: UITableViewCell {
    
    private enum Constant {
        static let leadingOffset: CGFloat = 10
        static let trailingOffset: CGFloat = -leadingOffset
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -topOffset
        
        enum SearchImage {
            static let imageName = "magnifyingglass"
            static let height: CGFloat = 15
            static let width: CGFloat = 15
        }
    }
    
    private let searchView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constant.SearchImage.imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .hpBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.font = .captionBold
        label.text = "검색어 자동완성"
        label.textColor = .hpBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func setup(model: SearchingRecommendCellModel) {
        recommendLabel.text = model.recommendText
    }
    
}

private extension SearchingRecommendCell {
    func setupViews() {
        selectionStyle = .none
        [searchView, recommendLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            searchView.heightAnchor.constraint(equalToConstant: Constant.SearchImage.height),
            searchView.widthAnchor.constraint(equalToConstant: Constant.SearchImage.width),
            searchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingOffset),
            searchView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            recommendLabel.leadingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: Constant.leadingOffset),
            recommendLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.traillingOffset),
            recommendLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.topOffset),
            recommendLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constant.bottomOffset)
        ])
    }
    
    func reset() {
        recommendLabel.text = ""
    }
}
