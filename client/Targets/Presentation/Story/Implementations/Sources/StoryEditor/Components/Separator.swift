//
//  Separator.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

class Separator: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension Separator {
    
    func setupViews() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1)
        ])
        
        backgroundColor = .hpGray4
    }
}
