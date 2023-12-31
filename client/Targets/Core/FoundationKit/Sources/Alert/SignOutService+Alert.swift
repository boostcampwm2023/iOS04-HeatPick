//
//  SignOutService+Alert.swift
//  FoundationKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

extension SignoutService {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .filter(\.isKeyWindow)
            .first
    }
    
    func presentAlert(type: AlertType, action: @escaping (() -> Void)) {
        DispatchQueue.main.async { [weak self] in
            self?.keyWindow?.rootViewController?
                .presentAlert(
                    title: type.title,
                    message: type.message,
                    okAction: action,
                    isCancelButtonEnabled: type.isCancellable
                )
        }
    }
    
}
