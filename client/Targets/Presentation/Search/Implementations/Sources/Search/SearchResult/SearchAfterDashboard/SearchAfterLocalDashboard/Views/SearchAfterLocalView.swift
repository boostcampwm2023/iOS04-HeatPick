//
//  SearchAfterLocalView.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DomainEntities
import DesignKit


protocol SearchAfterLocalViewDelegate: AnyObject {
    func searchAfterLocalViewDidTap(_ view: SearchAfterLocalView, model: SearchLocal)
}

final class SearchAfterLocalView: UIView {
    
    weak var delegate: SearchAfterLocalViewDelegate?
    
    private enum Constant {
        static let spacing: CGFloat = 5
    }
    
    private var model: SearchLocal?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.text = "제목"
        label.textColor = .hpBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let roadAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.text = "도로명 주소"
        label.textColor = .hpBlack
        label.numberOfLines = 1
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
    
    func setup(model: SearchLocal) {
        titleLabel.text = model.title
        roadAddressLabel.text = model.roadAddress
        self.model = model
    }
       
}

private extension SearchAfterLocalView {
    
    func setupViews() {
        [titleLabel, roadAddressLabel].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            roadAddressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            roadAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            roadAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            roadAddressLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupConfiguration() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(searchAfterLocalViewDidTap)
        )
        addGestureRecognizer(tapGesture)
    }
    
}

private extension SearchAfterLocalView {
    
    @objc func searchAfterLocalViewDidTap() {
        guard let model else { return }
        delegate?.searchAfterLocalViewDidTap(self, model: model)
    }
    
}

