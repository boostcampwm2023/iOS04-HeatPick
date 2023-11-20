//
//  AuthInterface.swift
//  AuthInterfaces
//
//  Created by 홍성준 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol SignInBuildable: Buildable {
    func build(withListener listener: SignInListener) -> ViewableRouting
}

public protocol SignInListener: AnyObject {
    func signInDidComplete()
}
