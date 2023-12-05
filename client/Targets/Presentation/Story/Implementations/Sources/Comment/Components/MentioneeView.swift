//
//  MentioneeView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class MentioneeView: UIView {

    private(set) var id: Int?
    
    private enum Constant {
        static let topInset: CGFloat = 7
        static let bottomInset: CGFloat = -topInset
        static let leadingInset: CGFloat = 10
        static let trailingInset: CGFloat = -leadingInset
        static let height: CGFloat = 30
    }
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .smallSemibold
        label.textColor = .hpWhite
        
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
    
    func setup(id: Int, name: String) {
        self.id = id
        usernameLabel.text = "@\(name)"
    }
}

private extension MentioneeView {
    
    func setupViews() {
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topInset),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingInset),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.trailingInset),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomInset),
        ])
        
        layer.cornerRadius = Constant.height / 2
        backgroundColor = .hpBlack.withAlphaComponent(0.5)
    }
}
