//
//  ImageCacheManager.swift
//  CoreKit
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public final class ImageCacheManager {
    
    public static let shared = ImageCacheManager()
    
    private let imageCacheRepository = ImageCacheRepository.shared
    
    private init() {}
    
    public func fetch(from url: String) -> Data? {
        imageCacheRepository.fetch(url)
    }
    
    public func set(_ data: Data, url: String) {
        imageCacheRepository.set(data, cacheKey: url)
    }
}
