//
//  HomeURLProtocol.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import CoreKit
import Foundation

public final class HomeURLProtocol: URLProtocol {
    
    private lazy var mocks: [String: Data?] = [
        HomeAPI.recommend.path: loadMockData(fileName: "HomeRecommendResponseMock"),
        HomeAPI.recommendLocation(lat: 0, lng: 0).path: loadMockData(fileName: "HomeRecommendLocationResponseMock")
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
           let mockData = mocks[path],
           let data = mockData,
           let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: String(describing: self), code: -1))
        }
    }
    
    public override func stopLoading() {}
    
    private func loadMockData(fileName: String) -> Data? {
        guard let url = Bundle.core.url(forResource: fileName, withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }
    
}
