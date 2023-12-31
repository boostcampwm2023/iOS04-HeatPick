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
    
    private lazy var mocks: [String: Data?] = [
        StoryAPI.metaData.path: loadMockData(fileName: "MetadataResponseMock"),
        StoryAPI.newStory(StoryContent(title: "",
                                       content: "",
                                       date: .now,
                                       category: StoryCategory(id: 0, title: ""),
                                       place: Location(lat: 0, lng: 0),
                                       badge: Badge(id: 0, title: ""))).path: loadMockData(fileName: "StoryCreateResponseMock"),
        StoryAPI.storyDetail(0).path: loadMockData(fileName: "StoryDetailResponseMock"),
        StoryAPI.follow(0).path: loadMockData(fileName: "FollowResponseMock"),
        StoryAPI.unfollow(0).path: loadMockData(fileName: "EmptyResponseMock"),
        StoryAPI.readComment(0).path: loadMockData(fileName: "CommentReadResponseMock"),
        StoryAPI.newComment(CommentContent(storyId: 0,
                                           content: "",
                                           mentions: [])).path: loadMockData(fileName: "EmptyResponseMock")
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
