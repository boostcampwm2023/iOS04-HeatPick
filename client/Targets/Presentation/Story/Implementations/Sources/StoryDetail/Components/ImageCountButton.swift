//
//  ImageCountButton.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class ImageCountButton: UIButton {

    enum ButtonType {
        case like
        case comment
        
        var imageName: String {
            switch self {
            case .comment: "bubble"
            case .like: "heart"
            }
        }
    }
    
    enum Constant {
        static let topSpacing: CGFloat = 5
        static let bottomSpacing: CGFloat = -Constant.topSpacing
        static let leadingSpacing: CGFloat = 5
        static let trailingSpacing: CGFloat = -Constant.leadingSpacing
    }
    
    private var type: ButtonType?
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .hpBlack
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.textAlignment = .center
        
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
    
    func setup(type: ButtonType) {
        image.image = UIImage(systemName: type.imageName)
        countLabel.text = "0"
        
    }
    
    func setup(count: Int) {
        countLabel.text = String(count)
    }

}

private extension ImageCountButton {
    
    func setupViews() {
        [image, countLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topSpacing),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.leadingSpacing),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomSpacing),
            
            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topSpacing),
            countLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constant.leadingSpacing),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomSpacing),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constant.trailingSpacing)
        ])
    }
}
