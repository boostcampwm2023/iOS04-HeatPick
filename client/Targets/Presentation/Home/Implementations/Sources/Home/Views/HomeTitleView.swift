//
//  HomeTitleCell.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

struct HomeTitleViewModel {
    let title: String
    let isButtonEnabled: Bool
}

final class HomeTitleView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllView: HomeSeeAllView = {
        let seeAllView = HomeSeeAllView()
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
    
    func setup(model: HomeTitleViewModel) {
        titleLabel.text = model.title
        seeAllView.isHidden = !model.isButtonEnabled
    }
    
}

private extension HomeTitleView {
    
    @objc private func seeAllViewDidTap() {
        
    }
    
}

private extension HomeTitleView {
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(seeAllView)
        
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
