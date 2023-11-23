//
//  StoryURLProtocol.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import DomainEntities

public final class StoryURLProtocol: URLProtocol {
    
    private lazy var mocks: [String: Data] = [
        StoryAPI.newStory(StoryContent(title: "", content: "", date: .now, category: .none, place: .init(lat: 0, lng: 0, address: nil), badgeId: 0)).path: storyCreateResponseMock()
    ]
    
    public override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        defer { client?.urlProtocolDidFinishLoading(self) }
        
        if let url = request.url,
           let path = request.url?.path(percentEncoded: true),
           let data = mocks[path],
           let response = HTTPURLResponse(url: url,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil) {
            
            client?.urlProtocol(self,
                                didReceive: response,
                                cacheStoragePolicy: .notAllowed)
            
            client?.urlProtocol(self, didLoad: data)
        }
        else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: "StoryCreateURLProtocol Error", code: -1))
        }
            
    }
    
    public override func stopLoading() {}
    
    private func storyCreateResponseMock() -> Data {
        let parameters: [String: Any] = [
            "storyId": 123
        ]
        return makeMock(paramters: parameters)
    }
    
    private func makeMock(paramters: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: paramters)
    }
}
