//
//  AuthURLProtocol.swift
//  NetworkAPIAuth
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public final class AuthURLProtocol: URLProtocol {
    
    private lazy var mocks: [String: Data] = [
        "/auth/signin": signInResponseMock(),
        "/auth/signup": signUpResponseMock()
    ]
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        defer { client?.urlProtocolDidFinishLoading(self) }
        if let url = request.url,
           let path = request.url?.path(percentEncoded: true),
           let data = mocks[path],
           let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: "SignInURLProtocol Error", code: -1))
        }
    }
    
    public override func stopLoading() {}
    
    private func signInResponseMock() -> Data {
        let parameters: [String: Any] = [
            "accessToken": "signInResponseMock"
        ]
        return makeMock(paramters: parameters)
    }
    
    private func signUpResponseMock() -> Data {
        let parameters: [String: Any] = [
            "accessToken": "signUpResponseMock"
        ]
        return makeMock(paramters: parameters)
    }
    
    private func makeMock(paramters: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: paramters)
    }
    
}
