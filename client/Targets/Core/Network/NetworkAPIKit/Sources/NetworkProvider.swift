//
//  NetworkProvider.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine

public final class NetworkProvider: Network {
    
    private enum NetworkRequest {
        case request(URLRequest)
        case upload(URLRequest, Data)
    }
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ target: Target) -> AnyPublisher<T, Error> {
        let isMultipartFormData: Bool = {
            switch target.task {
            case .multipart: return true
            default: return false
            }
        }()
        
        do {
            let networkRequest = try makeRequest(target, isMultipartFormData: isMultipartFormData)
            switch networkRequest {
            case .request(let request):
                return makeRequestPublisher(target, request: request)
            case .upload(let request, let body):
                return makeUploadPublisher(target, request: request, body: body)
            }
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    private func makeRequestPublisher<T: Decodable>(_ target: Target, request: URLRequest) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap { data, _ in
                return try JSONDecoder().decode(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }
    
    private func makeUploadPublisher<T: Decodable>(_ target: Target, request: URLRequest, body: Data) -> AnyPublisher<T, Error>  {
        let subject = PassthroughSubject<T, Error>()
        _Concurrency.Task {
            do {
                let (data, _) = try await session.upload(for: request, from: body)
                let dataResponse = try JSONDecoder().decode(T.self, from: data)
                subject.send(dataResponse)
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
    
    private func makeRequest(_ target: Target, isMultipartFormData: Bool = false) throws -> NetworkRequest {
        let boundary = UUID().uuidString
        let components: URLComponents? = {
            let endpoint = target.baseURL.appendingPathComponent(target.path)
            var components = URLComponents(url: endpoint, resolvingAgainstBaseURL: true)
            if case let .url(parameters) = target.task {
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
            return components
        }()
        
        guard let components, let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            if isMultipartFormData {
                target.header.withMultipartFormData(boundary: boundary)
            } else {
                request.httpBody = makeBody(target)
            }
            request.setHeader(target.header)
            request.httpMethod = target.method.rawValue
            
            return request
        }()
        
        if isMultipartFormData {
            guard let body = makeBody(target, boundary: boundary) else {
                throw NetworkError.emptyRequest
            }
            return .upload(request, body)
        } else {
            return .request(request)
        }
    }
    
    private func makeBody<T: Target>(
        _ target: T,
        boundary: String = UUID().uuidString
    ) -> Data? {
        switch target.task {
        case .plain:
            return nil
        case .data(let data):
            return data
        case .json(let encodable):
            return try? encodable.jsonData()
        case .url:
            return nil
        case .multipart(let formData):
            return formData.makeData(boundary: boundary)
        }
    }
    
}
