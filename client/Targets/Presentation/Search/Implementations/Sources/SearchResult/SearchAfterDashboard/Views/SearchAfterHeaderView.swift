//
//  SearchAfterTitleView.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

protocol SearchAfterHeaderViewDelegate: AnyObject {
    func searchAfterHeaderViewSeeAllViewDidTap()
}

final class SearchAfterHeaderView: UIView {
    
    weak var delegate: SearchAfterHeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllView: SearchAfterSeeAllView = {
        let seeAllView = SearchAfterSeeAllView()
        seeAllView.addTapGesture(target: self, action: #selector(seeAllViewDidTap))
        seeAllView.translatesAutoresizingMaskIntoConstraints = false
        return seeAllView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func isHiddenSeeAllView(_ isHidden: Bool) {
        seeAllView.isHidden = isHidden
    }
    
}

private extension SearchAfterHeaderView {
    
    @objc private func seeAllViewDidTap() {
        delegate?.searchAfterHeaderViewSeeAllViewDidTap()
    }
    
}

private extension SearchAfterHeaderView {
    
    private func setupViews() {
        [titleLabel, seeAllView].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            seeAllView.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
