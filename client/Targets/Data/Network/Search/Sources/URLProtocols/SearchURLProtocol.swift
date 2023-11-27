//
//  SearchURLProtocol.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import CoreKit
import Foundation

public final class SearchURLProtocol: URLProtocol {
    
    private lazy var mocks: [String: Data?] = [
        SearchAPI.recommend(searchText: "text").path: loadMockData(fileName: "SearchRecommendResponseMock"),
        SearchAPI.story(searchText: "text").path: loadMockData(fileName: "SearchStoryResponseMock"),
        SearchAPI.user(searchText: "text").path: loadMockData(fileName: "SearchUserResponseMock"),
        SearchAPI.searchResult(searchText: "text").path: loadMockData(fileName: "SearchResultResponseMock")
    ]
    
    public override class func canInit(with request: URLRequest) -> Bool { true }
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

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
    
    public override func stopLoading() { }
    
}

private extension SearchURLProtocol {
    
    func loadMockData(fileName: String) -> Data? {
        guard let url = Bundle.core.url(forResource: fileName, withExtension: "json") else { return nil }
        return try? Data(contentsOf: url)
    }
    
}
