//
//  SearchBeforeRecentSearchesView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

protocol searchBeforeRecentSearchViewDelegate: AnyObject {
    func recentSearchViewDidTap(_ recentSearch: String)
    func recentSearchViewDelete(_ recentSearch: String)
}

final class SearchBeforeRecentSearchView: UIView {
    
    weak var delegate: searchBeforeRecentSearchViewDelegate?
    
    private enum Constant {
        static let topOffset: CGFloat = 5
        static let bottomOffset: CGFloat = -topOffset
        static let leadingOffset: CGFloat = 15
        static let trailingOffset: CGFloat = -leadingOffset
        
        enum ImageView {
            static let image = "xmark"
            static let size: CGFloat = 20
            static let leadingOffset: CGFloat = 5
            static let trailingOffset: CGFloat = -leadingOffset
        }
    }
    
    private var recentSearch: String?
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .bodyRegular
        label.text = "최근 검색어"
        label.textColor = .hpBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .hpGray2
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: Constant.ImageView.image)
        imageView.addTapGesture(target: self, action: #selector(recentSearchViewDelete))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfiguration()
        setupViews()
    }

    
    func setup(_ recentSearch: String) {
        self.recentSearch = recentSearch
        titleLabel.text = recentSearch
    }
    
}

private extension SearchBeforeRecentSearchView {
    
    func setupViews() {
        [titleLabel, deleteImage].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: deleteImage.leadingAnchor, constant: Constant.ImageView.trailingOffset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
            
            deleteImage.widthAnchor.constraint(equalToConstant: Constant.ImageView.size),
            deleteImage.heightAnchor.constraint(equalToConstant: Constant.ImageView.size),
            deleteImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            deleteImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.ImageView.trailingOffset),
        ])
    }
    
    func setupConfiguration() {
        clipsToBounds = true
        backgroundColor = .hpGray5
        layer.cornerRadius = Constants.cornerRadiusSmall
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray3.cgColor
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(recentSearchViewDidTap)
        )
        addGestureRecognizer(tapGesture)
    }

}

private extension SearchBeforeRecentSearchView {
    
    @objc func recentSearchViewDidTap() {
        guard let recentSearch else { return }
        delegate?.recentSearchViewDidTap(recentSearch)
    }
    
    @objc func recentSearchViewDelete() {
        guard let recentSearch else { return }
        delegate?.recentSearchViewDelete(recentSearch)
    }
    
}
