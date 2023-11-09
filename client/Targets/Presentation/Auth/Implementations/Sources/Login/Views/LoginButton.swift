//
//  LoginButton.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

enum LoginType {
    case naver
    case apple
    
    var icon: UIImage {
        switch self {
        case .naver:
            return .naverButtonIcon
        case .apple:
            return .appleButtonIcon
        }
    }
    
    var title: String {
        switch self {
        case .naver:
            return "네이버로 계속하기"
        case .apple:
            return "Apple로 계속하기"
        }
    }
    
    var backgroundColor: String {
        switch self {
        case .naver:
            return "03C75A"
        case .apple:
            return "000000"
        }
    }
}

final class LoginButton: UIButton {
    
    func setup(type: LoginType) {
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .hpWhite
        configuration.baseBackgroundColor = .init(hex: type.backgroundColor)
        configuration.title = type.title
        configuration.image = type.icon
        configuration.imagePlacement = .leading
        configuration.titleAlignment = .center
        
        let titleAttribute = UIConfigurationTextAttributesTransformer { transform in
            var transform = transform
            transform.font = UIFont.bodySemibold
            return transform
        }
        configuration.titleTextAttributesTransformer = titleAttribute
        
        self.configuration = configuration
    }
    
}
