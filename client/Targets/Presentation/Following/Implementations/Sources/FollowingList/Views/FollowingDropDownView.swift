//
//  FollowingDropDownView.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import DomainEntities

protocol FollowingDropDownViewDelegate: AnyObject {
    
    func followingDropDownViewDidSelectOption(_ view: FollowingDropDownView, option: HomeFollowingSortOption)
    
}

final class FollowingDropDownView: UIView {
    
    private enum Constant {
        static let imageName = "chevron.down"
        static let imageWidth: CGFloat = 15
        static let imageHeight = imageWidth
    }
    
    weak var delegate: FollowingDropDownViewDelegate?
    private var options: [HomeFollowingSortOption] = []
    
    private let containerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .hpWhite
        button.setTitleColor(.clear, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.hpGray4.cgColor
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: Constant.imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .hpBlack
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "최신순"
        label.textColor = .hpBlack
        label.font = .captionRegular
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
    
    func setup(options: [HomeFollowingSortOption]) {
        self.options = options
        
        let menu = options.map { option -> UIAction in
            return UIAction(title: option.title) { [weak self] action in
                self?.titleLabel.text = action.title
                self?.didSelectOption(title: action.title)
            }
        }
        containerButton.menu = UIMenu(options: .displayInline, children: menu)
        containerButton.showsMenuAsPrimaryAction = true
        containerButton.changesSelectionAsPrimaryAction = true
    }
    
}

private extension FollowingDropDownView {
    
    func setupViews() {
        addSubview(containerButton)
        [imageView, titleLabel].forEach(containerButton.addSubview)
        
        NSLayoutConstraint.activate([
            containerButton.topAnchor.constraint(equalTo: topAnchor),
            containerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: Constant.imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerButton.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: containerButton.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: containerButton.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: containerButton.bottomAnchor, constant: -5)
        ])
    }
    
    func didSelectOption(title: String) {
        guard let option = options.first(where: { $0.title == title }) else { return }
        delegate?.followingDropDownViewDidSelectOption(self, option: option)
    }
    
}
