//
//  SearchHomeListSheetPresentationController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class SearchHomeListSheetPresentationController: UISheetPresentationController {
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let tabBarController = presentingViewController as? UITabBarController,
              let containerView else { return }
        containerView.clipsToBounds = true
        var frame = containerView.frame
        frame.size.height -= tabBarController.tabBar.frame.height
        containerView.frame = frame
        
    }
}
