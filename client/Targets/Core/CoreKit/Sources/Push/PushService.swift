//
//  PushService.swift
//  FoundationKit
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import FoundationKit
import FirebaseMessaging

public protocol PushServiceListener: AnyObject {
    func pushServiceDidReceiveToken(_ serivce: PushService, token: String)
}

public final class PushService {
    
    public static let shared = PushService()
    
    public weak var listener: PushServiceListener?
    
    private(set) public var deviceToken: Data?
    private(set) public var settings: UNNotificationSettings?
    private(set) public var isRegisteredForRemoteNotifications: Bool?
    
    private init() {
        fetchNotificationSettings()
    }
    
    public func register(deviceToken: Data) {
        guard self.deviceToken != deviceToken else { return }
        self.deviceToken = deviceToken
    }
    
    public func updateToken() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
            Messaging.messaging().token { token, _ in
                guard let token, let tokenData = token.data(using: .utf8) else { return }
                if let localTokenData = SecretManager.read(type: .messagingToken),
                   let localToken = String(data: localTokenData, encoding: .utf8) {
                    if localToken == token { return }
                }
                self.listener?.pushServiceDidReceiveToken(self, token: token)
                SecretManager.write(type: .messagingToken, data: tokenData)
            }
        }
    }
    
    public func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            self.fetchNotificationSettings(completion: completion)
        }
    }
    
    public func requestAuthorization() async throws -> Bool {
        try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        return await fetchNotificationSettings()
    }
    
    public func fetchNotificationSettings() async -> Bool {
        return await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                self.settings = settings
                let granted = settings.authorizationStatus == .authorized
                continuation.resume(returning: granted)
            }
        }
    }
    
    public func fetchNotificationSettings(completion: ((Bool) -> Void)? = nil) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.settings = settings
                let granted = settings.authorizationStatus == .authorized
                completion?(granted)
            }
        }
    }
    
    public func registerNotification() {
        guard isRegisteredForRemoteNotifications != true else { return }
        isRegisteredForRemoteNotifications = true
        UserDefaults.standard.setValue(true, forKey: .remoteNotification)
        updateToken()
    }
    
    public func registerNotification() async {
        guard isRegisteredForRemoteNotifications != true else { return }
        isRegisteredForRemoteNotifications = true
        UserDefaults.standard.setValue(true, forKey: .remoteNotification)
        await updateToken()
    }
    
    public func updateToken() async {
        return await withUnsafeContinuation { continuation in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
                Messaging.messaging().token { token, _ in
                    guard let token, let tokenData = token.data(using: .utf8) else {
                        continuation.resume()
                        return
                    }
                    if let localTokenData = SecretManager.read(type: .messagingToken),
                       let localToken = String(data: localTokenData, encoding: .utf8) {
                        if localToken == token {
                            continuation.resume()
                            return
                        }
                    }
                    self.listener?.pushServiceDidReceiveToken(self, token: token)
                    SecretManager.write(type: .messagingToken, data: tokenData)
                    continuation.resume()
                }
            }
        }
    }
    
}
