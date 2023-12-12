//
//  MyPageStoryEmptyView.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

final class ProfileStoryEmptyView: UIView {
    
    private enum Constant {
        static let topOffset: CGFloat = 40
        static let bottomOffset: CGFloat = -topOffset
        static let spacing: CGFloat = 5
        static let title = "작성된 스토리가 없어요"
        static let subtitle = "스토리를 작성해보세요"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpGray1
        label.font = .bodySemibold
        label.textAlignment = .center
        label.text = Constant.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpBlack
        label.font = .captionRegular
        label.textAlignment = .center
        label.text = Constant.subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension ProfileStoryEmptyView {
    
    func setupViews() {
        [titleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset)
        ])
    }
    
}
