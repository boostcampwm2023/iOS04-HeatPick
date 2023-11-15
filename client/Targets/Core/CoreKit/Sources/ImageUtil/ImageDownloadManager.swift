//
//  ImageDownloadManager.swift
//  CoreKit
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public final class ImageDownloadManager {
    
    public static let shared = ImageDownloadManager()
    
    private init() {}
    
    private let taskQueue = DispatchQueue(label: "ImageDownloadManager")
    
    private var tasks: [AnyHashable: Task<Data, Error>] = [:]
    
    public func cancel(key: AnyHashable) {
        taskQueue.async {
            self.tasks[key]?.cancel()
            self.tasks[key] = nil
        }
    }
    
    public func download(key: AnyHashable, url urlString: String) -> Task<Data, Error>? {
        guard let url = URL(string: urlString) else { return nil }
        let task = Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        
        taskQueue.async {
            self.tasks[key] = task
        }
        return task
    }
    
    public func data(key: AnyHashable, url urlString: String) async -> Data? {
        return try? await download(key: key, url: urlString)?.value
    }
    
}
