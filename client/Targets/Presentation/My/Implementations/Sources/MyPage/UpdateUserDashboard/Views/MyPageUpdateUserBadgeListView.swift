//
//  MyPageUpdateUserBadgeListView.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

protocol MyPageUpdateUserBadgeListViewDelegate: AnyObject {
    func didTapUserBadgeView(_ badgeId: Int)
}

final class MyPageUpdateUserBadgeListView: UIView {
    
    weak var delegate: MyPageUpdateUserBadgeListViewDelegate?
    
    private enum Constant {
        static let topOffset: CGFloat = 15
        static let bottomOffset: CGFloat = -topOffset
        static let spacing: CGFloat = 20
        enum TitleLabel {
            static let title = "칭호"
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.TitleLabel.title
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = Constant.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(badges: [MyPageUpdateUserBadgeViewModel]) {
        badges.forEach { badge in
            let contentView = MyPageUpdateUserBadgeView()
            contentView.setup(badge: badge)
            contentView.delegate = self
            stackView.addArrangedSubview(contentView)
        }
    }
    
}

private extension MyPageUpdateUserBadgeListView {
    
    func setupViews() {
        [titleLabel, stackView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
        ])
    }
    
}

extension MyPageUpdateUserBadgeListView: MyPageUpdateUserBadgeViewDelegate {
    
    func didTapUserBadgeView(_ badgeId: Int) {
        delegate?.didTapUserBadgeView(badgeId)
    }
    
}
