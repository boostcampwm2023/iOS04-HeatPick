//
//  StorySeeAllPresentable.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs

public protocol StorySeeAllPresentable: Presentable {
    var listener: StorySeeAllPresentableListener? { get set }
    func updateTitle(_ title: String)
    func setup(models: [StorySmallTableViewCellModel])
    func append(models: [StorySmallTableViewCellModel])
    func startLoading()
    func stopLoading()
}
