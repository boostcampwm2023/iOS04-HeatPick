//
//  HomeRecommendContentView.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

struct HomeRecommendContentViewModel {
    let id: Int
    let title: String
    let subtitle: String
    let imageURL: String
}

final class HomeRecommendContentView: UIView {
    
    var id: Int?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpWhite
        label.font = .bodySemibold
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .hpWhite
        label.font = .bodyRegular
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    deinit {
        imageView.cancel()
    }
    
    func setup(model: HomeRecommendContentViewModel) {
        id = model.id
        imageView.load(from: model.imageURL)
        
        titleLabel.attributedText = NSMutableAttributedString(string: model.title)
            .foregroundColor(.hpWhite)
            .strokeColor(.hpBlack)
            .strokeWidth(-3.0)

        subtitleLabel.attributedText = NSMutableAttributedString(string: model.subtitle)
            .foregroundColor(.hpWhite)
            .strokeColor(.hpBlack)
            .strokeWidth(-2.5)
    }
    
}

private extension HomeRecommendContentView {
    
    func setupViews() {
        let width: CGFloat = (UIScreen.main.bounds.width) - 40
        let height = width - 40
        [imageView, titleLabel, subtitleLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.traillingOffset),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constants.leadingOffset),
            subtitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.traillingOffset)
        ])
    }
    
}
