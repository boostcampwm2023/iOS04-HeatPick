//
//  GithubLoginRepository.swift
//  DataRepositories
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

import CoreKit
import FoundationKit
import DomainInterfaces
import NetworkAPIKit
import GithubAPI

public final class GithubLoginRepository: GithubLoginRepositoryInterface {
    public static let shared = GithubLoginRepository(session: NetworkProvider(session: URLSession.shared, signOutService: SignoutService.shared))
    private let session: Network
    
    public var accessToken: AnyPublisher<String, Never> { accessTokenCurrentValue.eraseToAnyPublisher() }
    private var accessTokenCurrentValue: PassthroughSubject<String, Never> = .init()
    
    public init(session: Network) {
        self.session = session
    }
    
    private enum Constant {
        static let githubAuthorizeUrl = "https://github.com/login/oauth/authorize"
        static let scope = "read:user,user:email"
    }
    
    public func requestLogin() {
        requestCode()
    }
    
    public func requestCode() {
        guard var components = URLComponents(string: Constant.githubAuthorizeUrl) else { return }
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Secret.githubLoginClientId.value),
            URLQueryItem(name: "scope", value: Constant.scope),
        ]
        
        guard let urlString = components.url?.absoluteString,
              let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url)
    }
    
    public func requestToken(with code: String) {
        let target = GithubAPI.accessToken(code)
        _Concurrency.Task { [weak self] in
            guard let self else { return }
            await session.request(target)
                .onSuccess(with: self, { (this, accessCodeResponse: AccessTokenResponseDTO) in
                    this.accessTokenCurrentValue.send(accessCodeResponse.toDomain())
                })
                .onFailure { error in
                    Log.make(message: "fail to load github accesstoken with \(error.localizedDescription)", log: .network)
                }
        }
    }
    
}
