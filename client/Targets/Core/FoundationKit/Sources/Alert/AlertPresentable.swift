//
//  AlertPresentable.swift
//  FoundationKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public protocol AlertPresentable {
    func presentAlert(
        title: String,
        message: String,
        okAction: @escaping (() -> Void),
        isCancelButtonEnabled: Bool
    )
}

public extension AlertPresentable where Self: UIViewController {
    
    func presentAlert(
        title: String,
        message: String,
        okAction: @escaping (() -> Void),
        isCancelButtonEnabled: Bool = false
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "확인", style: .default, handler: { _ in
            okAction()
        }))
        if isCancelButtonEnabled {
            alert.addAction(.init(title: "취소", style: .cancel))
        }
        present(alert, animated: true)
    }
    
}

extension UIViewController: AlertPresentable {}
