//
//  NaverLoginRepository.swift
//  DataRepositories
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import CoreKit
import DomainInterfaces

import NaverThirdPartyLogin

public final class NaverLoginRepository: NSObject, NaverLoginRepositoryInterface {
    
    public var accessToken: AnyPublisher<String, Never> { accessTokenCurrentValue.eraseToAnyPublisher() }
    private var accessTokenCurrentValue: PassthroughSubject<String, Never> = .init()
    private let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    public override init() { }
    
    public func setup() {
        instance?.isInAppOauthEnable = true
        instance?.isNaverAppOauthEnable = true
        instance?.isOnlyPortraitSupportedInIphone()
        instance?.appName = "heatpick"
        instance?.consumerKey = "jVSHpqp9TC4MltNI4lVJ"
        instance?.consumerSecret = ""
        instance?.serviceUrlScheme = "heatpick"
    }
    
    public func requestLogin() {
        guard let token = instance?.accessToken else {
            instance?.delegate = self
            instance?.requestThirdPartyLogin()
            return
        }
        accessTokenCurrentValue.send(token)
    }
    
}

extension NaverLoginRepository: NaverThirdPartyLoginConnectionDelegate {
    
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        guard let token = instance?.accessToken else { return }
        accessTokenCurrentValue.send(token)
    }
    
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
    }
    
    public func oauth20ConnectionDidFinishDeleteToken() {
        
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        
    }
    
}
