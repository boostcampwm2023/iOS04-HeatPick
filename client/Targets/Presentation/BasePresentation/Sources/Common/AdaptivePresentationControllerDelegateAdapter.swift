//
//  AdaptivePresentationControllerDelegateAdapter.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public protocol AdaptivePresentationControllerDelegate: AnyObject {
    func controllerDidDismiss()
}

public final class AdaptivePresentationControllerDelegateAdapter: NSObject, UIAdaptivePresentationControllerDelegate {
    
    public weak var delegate: AdaptivePresentationControllerDelegate?
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.controllerDidDismiss()
    }
    
}
