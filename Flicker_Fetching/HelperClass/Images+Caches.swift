//
//  Images+Caches.swift
//  Flicker_Fetching
//
//  Created by Bhavesh's Mac on 11/04/25.
//

import Foundation
import UIKit

/// A singleton class responsible for caching downloaded images using NSCache.
class ImageCache {

    /// Shared singleton instance of ImageCache.
    static let shared = ImageCache()

    /// Private initializer to prevent external instantiation.
    private init() {}

    
    /// Internal image cache storage.
    private let cache = NSCache<NSString, UIImage>()


    /// Retrieves a cached image for the given URL string.
    ///
    /// - Parameter url: The URL string of the image.
    /// - Returns: The cached `UIImage` if available; otherwise, `nil`.
    func image(for url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }


    /// Saves an image to the cache with the associated URL string as the key.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to cache.
    ///   - url: The URL string to associate with the image.
    func save(image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}
