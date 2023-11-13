//
//  UIImage+Cache.swift
//  CoreKit
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    func load(from url: String?) {
        guard let url = url else { return }
            
        if let imageData = ImageCacheManager.shared.fetch(from: url) {
            image = UIImage(data: imageData)
            return
        }
        
        Task {
            guard let data = await ImageDownloadManager.shared.data(key: self, url: url) else { return }
            ImageCacheManager.shared.set(data, url: url)
            image = UIImage(data: data)
        }
    }
    
    func cancel() {
        ImageDownloadManager.shared.cancel(key: self)
    }
    
}
