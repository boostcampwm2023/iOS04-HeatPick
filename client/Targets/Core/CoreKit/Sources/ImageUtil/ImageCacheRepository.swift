//
//  ImageCacheRepository.swift
//  DataRepositories
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public final class ImageCacheRepository {
    
    public static let shared = ImageCacheRepository(fileManager: FileManager.default)
    
    private let cache = NSCache<NSString, NSData>()
    private let fileManager: FileManager
    
    public init(fileManager: FileManager) {
        self.fileManager = fileManager
        cache.countLimit = 200
    }
    
    public func fetch(_ cacheKey: String) -> Data? {
        if let cacheData = fetchMemoryData(cacheKey) {
            return cacheData
        }
        return nil
    }
    
    public func set(_ data: Data, cacheKey: String) {
        setMemory(data, cacheKey: cacheKey)
        setDisk(data, cacheKey: cacheKey)
    }
    
    private func fetchMemoryData(_ cacheKey: String) -> Data? {
        return cache.object(forKey: cacheKey as NSString) as? Data
    }
    
    private func fetchDiskData(_ cacheKey: String) -> Data? {
        guard let url = generateFileURL(cacheKey: cacheKey) else { return nil }
        return try? Data(contentsOf: url)
    }
    
    private func setMemory(_ data: Data, cacheKey: String) {
        cache.setObject(data as NSData, forKey: cacheKey as NSString)
    }
    
    private func setDisk(_ data: Data, cacheKey: String) {
        guard let url = generateFileURL(cacheKey: cacheKey) else { return }
        try? fileManager.createDirectory(atPath: url.path(), withIntermediateDirectories: true)
        fileManager.createFile(atPath: url.path(), contents: data)
    }
    
    private func generateFileURL(cacheKey: String) -> URL? {
        return fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: cacheKey)
    }
    
}
