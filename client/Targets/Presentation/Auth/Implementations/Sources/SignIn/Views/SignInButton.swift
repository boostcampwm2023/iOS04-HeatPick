//
//  LoginButton.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

enum SignInType {
    
    case naver
    case apple
    
    var image: UIImage {
        switch self {
        case .naver:
            return .naverButton
        case .apple:
            return .appleButton
        }
    }
    
}

final class SignInButton: UIButton {
    
    func setup(type: SignInType) {
        setImage(type.image, for: .normal)
    }
    
}
