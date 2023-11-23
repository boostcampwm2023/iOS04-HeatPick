//
//  SignOutService.swift
//  FoundationKit
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine

public protocol SignOutServiceInterface: AnyObject {
    
    var signOutCompleted: AnyPublisher<Bool, Never> { get }
    
}

public protocol SignOutRequestServiceInterface: AnyObject {
    
    func signOut()
    
}

public final class SignoutService: SignOutServiceInterface, SignOutRequestServiceInterface {
    
    public static let shared = SignoutService()
    
    public var signOutCompleted: AnyPublisher<Bool, Never> {
        return signOutCompletedSubject.eraseToAnyPublisher()
    }
    
    private var signOutCompletedSubject = PassthroughSubject<Bool, Never>()
    
    private init() {}
    
    public func signOut() {
        SecretManager.remove(type: .accessToken)
        signOutCompletedSubject.send(true)
    }
    
}
