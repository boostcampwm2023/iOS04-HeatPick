//
//  UserEditBadgeView.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

protocol UserInfoEditBadgeViewDelegate: AnyObject {
    func didTapUserBadgeView(_ badgeId: Int)
}

final class UserInfoEditBadgeView: UIView {
    
    weak var delegate: UserInfoEditBadgeViewDelegate?
    
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
    
    func setup(models: [UserBadgeViewModel]) {
        models.forEach { model in
            let contentView = UserBadgeView()
            contentView.setup(model: model)
            contentView.delegate = self
            stackView.addArrangedSubview(contentView)
        }
    }
    
}

private extension UserInfoEditBadgeView {
    
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

extension UserInfoEditBadgeView: UserBadgeViewDelegate {
    
    func didTapUserBadgeView(_ badgeId: Int) {
        delegate?.didTapUserBadgeView(badgeId)
    }
    
}
