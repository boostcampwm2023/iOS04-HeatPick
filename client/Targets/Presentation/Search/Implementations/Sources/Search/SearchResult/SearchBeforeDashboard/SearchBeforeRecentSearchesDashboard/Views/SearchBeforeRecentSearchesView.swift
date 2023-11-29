//
//  SearchBeforeRecentSearchesView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

protocol searchBeforeRecentSearchesViewDelegate: AnyObject {
    func didTapSearchBeforeRecentSearchesView(searchText: String)
}

final class SearchBeforeRecentSearchesView: UIView {
    
    weak var delegate: searchBeforeRecentSearchesViewDelegate?
    
    private enum Constant {
        static let topOffset: CGFloat = 5
        static let bottomOffset: CGFloat = -topOffset
        static let leadingOffset: CGFloat = 15
        static let trailingOffset: CGFloat = -leadingOffset
    }
    
    private var searchText: String?
    
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
        setupConfiguration()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfiguration()
        setupViews()
    }

    
    func setup(_ searchText: String) {
        self.searchText = searchText
        titleLabel.text = searchText
    }
    
}

private extension SearchBeforeRecentSearchesView {
    
    func setupViews() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.trailingOffset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
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
            action: #selector(didTapSearchBeforeRecentSearchesView)
        )
        addGestureRecognizer(tapGesture)
    }

}

private extension SearchBeforeRecentSearchesView {
    
    @objc func didTapSearchBeforeRecentSearchesView() {
        guard let searchText else { return }
        delegate?.didTapSearchBeforeRecentSearchesView(searchText: searchText)
    }
    
}
