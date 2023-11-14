//
//  SignInURLProtocol.swift
//  NetworkAPIAuth
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public final class SignInURLProtocol: URLProtocol {
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        defer { client?.urlProtocolDidFinishLoading(self) }
        if let data = mockData,
           let url = request.url,
           let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: "SignInURLProtocol Error", code: -1))
        }
    }
    
    public override func stopLoading() {}
    
    private var mockData: Data? {
        let json = """
{
    "token": "SampleToken"
}
"""
        return json.data(using: .utf8)
    }
    
    
}
