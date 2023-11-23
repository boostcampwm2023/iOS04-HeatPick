//
//  NetworkProvider.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/10/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import FoundationKit

public final class NetworkProvider: Network {
    
    private enum NetworkRequest {
        case request(URLRequest)
        case upload(URLRequest, Data)
    }
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ target: Target) async -> Result<T, Error> {
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
                return try await executeRequest(request)
                
            case .upload(let request, let body):
                return try await executeUpload(request, from: body)
            }
        } catch {
            return .failure(error)
        }
    }
    
    private func executeRequest<T: Decodable>(_ request: URLRequest) async throws -> Result<T, Error> {
        let (data, urlResponse) = try await session.data(for: request)
        interceptResponseIfNeeded(urlResponse)
        let response =  try JSONDecoder().decode(T.self, from: data)
        return .success(response)
    }
    
    private func executeUpload<T: Decodable>(_ request: URLRequest, from body: Data) async throws -> Result<T, Error> {
        let (data, urlResponse) = try await session.upload(for: request, from: body)
        interceptResponseIfNeeded(urlResponse)
        let response = try JSONDecoder().decode(T.self, from: data)
        return .success(response)
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
                request.setHeader(target.header.withMultipartFormData(boundary: boundary))
            } else {
                request.httpBody = makeBody(target)
                request.setHeader(target.header)
            }
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
    
    private func interceptResponseIfNeeded(_ response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse,
              let errorCode = NetworkErrorCode(rawValue: httpResponse.statusCode)
        else {
            return
        }
        
        switch errorCode {
        case .invalidToken:
            SignoutService.shared.signOut(type: .invalidToken)
            
        default:
            return
        }
    }
    
}
