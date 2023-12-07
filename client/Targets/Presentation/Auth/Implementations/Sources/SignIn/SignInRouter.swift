//
//  LoginRouter.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import AuthInterfaces
import DomainEntities

protocol SignInInteractable: Interactable,
                             SignUpListener,
                             SignUpSuccessListener,
                                LocationAuthorityListener,
                             NotificationPermissionListener {
    var router: SignInRouting? { get set }
    var listener: SignInListener? { get set }
}

protocol SignInViewControllable: ViewControllable {}

final class SignInRouter: ViewableRouter<SignInInteractable, SignInViewControllable>, SignInRouting {
    
    private let signUpBuilder: SignUpBuildable
    private var signUpRouter: ViewableRouting?
    
    private let signUpSuccessBuilder: SignUpSuccessBuildable
    private var signUpSuccessRouter: ViewableRouting?
    
    private let locationAuthorityBuilder: LocationAuthorityBuildable
    private var locationAuthorityRouter: ViewableRouting?
    
    private let notificationPermissionBuilder: NotificationPermissionBuildable
    private var notificationPermissionRouter: ViewableRouting?
    
    init(
        interactor: SignInInteractable,
        viewController: SignInViewControllable,
        signUpBuilder: SignUpBuildable,
        signUpSuccessBuilder: SignUpSuccessBuildable,
        locationAuthorityBuilder: LocationAuthorityBuildable,
        notificationPermissionBuilder: NotificationPermissionBuildable
    ) {
        self.signUpBuilder = signUpBuilder
        self.signUpSuccessBuilder = signUpSuccessBuilder
        self.locationAuthorityBuilder = locationAuthorityBuilder
        self.notificationPermissionBuilder = notificationPermissionBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignUp(with service: SignInService) {
        guard signUpRouter == nil else { return }
        let router = signUpBuilder.build(withListener: interactor, service: service)
        pushRouter(router, animated: true)
        signUpRouter = router
    }
    
    func detachSignUp() {
        guard let router = signUpRouter else { return }
        popRouter(router, animated: true)
        signUpRouter = nil
    }
    
    func attachSignUpSuccess() {
        guard signUpSuccessRouter == nil else { return }
        let router = signUpSuccessBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        signUpSuccessRouter = router
    }
    
    func detachSignUpSuccess() {
        guard let router = signUpSuccessRouter else { return }
        popRouter(router, animated: true)
        signUpSuccessRouter = nil
    }
    
    func attachLocationAuthority() {
        guard locationAuthorityRouter == nil else { return }
        let router = locationAuthorityBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        locationAuthorityRouter = router
    }
    
    func detachLocationAuthority() {
        guard let router = locationAuthorityRouter else { return }
        popRouter(router, animated: true)
        locationAuthorityRouter = nil
    }
    
    func attachNotificationPermission() {
        guard notificationPermissionRouter == nil else { return }
        let router = notificationPermissionBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        notificationPermissionRouter = router
    }
    
    func detachNotificationPermission() {
        guard let router = notificationPermissionRouter else { return }
        popRouter(router, animated: true)
        notificationPermissionRouter = nil
    }
    
}
