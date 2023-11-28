//
//  SearchMapStoryView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import DomainEntities
import BasePresentation

struct SearchMapStoryViewModel {
    let storyID: Int
    let thumbnailImageURL: String
    let title: String
    let subtitle: String
    let likes: Int
    let comments: Int
}

final class SearchMapStoryView: UIView {
    
    private enum Constant {
        static let xOffset: CGFloat = 20
        static let yOffset: CGFloat = 15
    }
    
    var storyID: Int?
    
    private lazy var storyView: StorySmallView = {
        let storyView = StorySmallView()
        storyView.translatesAutoresizingMaskIntoConstraints = false
        return storyView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(model: SearchMapStoryViewModel) {
        storyID = model.storyID
        storyView.setup(model: .init(
            thumbnailImageURL: model.thumbnailImageURL,
            title: model.title,
            subtitle: model.subtitle,
            likes: model.likes,
            comments: model.comments
        ))
    }
    
}

private extension SearchMapStoryView {
    
    func setupViews() {
        backgroundColor = .hpWhite
        addSubview(storyView)
        
        NSLayoutConstraint.activate([
            storyView.topAnchor.constraint(equalTo: topAnchor, constant: Constant.yOffset),
            storyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.xOffset),
            storyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.xOffset),
            storyView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.yOffset)
        ])
    }
    
}
