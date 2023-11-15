//
//  UISheetPresentationController+.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

extension UISheetPresentationController.Detent.Identifier {
    static let small = UISheetPresentationController.Detent.Identifier("small")
}

extension UISheetPresentationController.Detent {
    class func small() -> UISheetPresentationController.Detent {
        UISheetPresentationController.Detent.custom(identifier: .small) { 0.2 * $0.maximumDetentValue }
    }
}
