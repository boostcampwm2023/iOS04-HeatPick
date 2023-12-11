//
//  UserSeeAllPresentable.swift
//  BasePresentation
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs

public protocol UserSeeAllPresentable: Presentable {
    var listener: UserSeeAllPresentableListener? { get set }
    func updateTitle(_ title: String)
    func setup(models: [UserSmallTableViewCellModel])
    func append(models: [UserSmallTableViewCellModel])
    func startLoading()
    func stopLoading()
}
