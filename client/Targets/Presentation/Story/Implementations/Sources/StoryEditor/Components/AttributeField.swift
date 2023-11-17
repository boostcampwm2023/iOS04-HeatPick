//
//  AttributeField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

class AttributeField: UITableView {

    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
        
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
