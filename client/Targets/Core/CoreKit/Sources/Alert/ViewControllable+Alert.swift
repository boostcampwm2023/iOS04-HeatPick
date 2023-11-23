//
//  ViewControllable+Alert.swift
//  CoreKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import FoundationKit
import ModernRIBs

public extension ViewControllable {
    
    func present(type: AlertType, okAction: @escaping (() -> Void)) {
        uiviewController.presentAlert(
            title: type.title,
            message: type.message,
            okAction: okAction,
            isCancelButtonEnabled: type.isCancellable
        )
    }
    
}
