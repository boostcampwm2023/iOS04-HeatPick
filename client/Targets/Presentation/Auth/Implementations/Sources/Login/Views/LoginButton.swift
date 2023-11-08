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
    
    var imageName: String {
        switch self {
        case .naver:
            return ""
        case .apple:
            return ""
        }
    }
    
    var buttonTitle: String {
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
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .init(hex: type.backgroundColor)
        configuration.title = type.buttonTitle
        configuration.image = UIImage(named: type.imageName)
        configuration.imagePlacement = .leading
        configuration.titleAlignment = .center
        
        self.configuration = configuration
    }
    
}
