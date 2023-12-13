//
//  SearchStoryGuideView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

final class SearchStoryGuideView: UIView {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
    }
    
    func showWithAnimation() {
        isUserInteractionEnabled = true
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.backgroundColor = .hpBlack.withAlphaComponent(0.4)
                self.titleLabel.textColor = .hpWhite
            }
        )
    }
    
    func hideWithAnimation() {
        isUserInteractionEnabled = false
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.backgroundColor = .clear
                self.titleLabel.textColor = .clear
            },
            completion: { _ in
                self.isHidden = true
            }
        )
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupAttributes() {
        self.do {
            $0.backgroundColor = .clear
            $0.addTapGesture(target: self, action: #selector(guideViewDidTap))
            $0.isUserInteractionEnabled = false
        }
        
        titleLabel.do {
            $0.text = "지도를 탭하여 스토리를 작성해보세요!"
            $0.font = .largeSemibold
            $0.textColor = .clear
            $0.textAlignment = .center
            $0.lineBreakStrategy = .hangulWordPriority
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @objc private func guideViewDidTap() {
        hideWithAnimation()
    }
    
}
