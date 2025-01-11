//
//  ImageCache.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import SwiftUI

class ImageCache {
    
    static let shared = ImageCache()

    private let urlCache: URLCache
    
    private init() {
        let memoryCapacity = 100 * 1024 * 1024 // 100 MB
        let diskCapacity = 500 * 1024 * 1024  // 500 MB
        urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ImageCache")
        URLCache.shared = urlCache
    }
    
    func getImage(_ url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        
        // Return cached image if it exists
        if let cachedResponse = urlCache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        
        // Make network request for image
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Cache the image data
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: request)
        return UIImage(data: data)
    }
    
    func clear() {
        urlCache.removeAllCachedResponses()
    }
}
