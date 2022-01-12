//
//  ImageCache.swift
//  PokeAPI
//
//  Created by Roderick Presswood on 1/12/22.
//

import Foundation

class ImageCache {
    
    static let sharedCache = ImageCache()
    
    private let cache: NSCache<NSString, NSData>
    
    private init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
        self.cache = cache
    }
        
    func set(data: Data, url: String) {
        let key = NSString(string: url)
        let object = NSData(data: data)
        self.cache.setObject(object, forKey: key)
    }
    
    func get(url: String) -> Data? {
        let key = NSString(string: url)
        guard let object = self.cache.object(forKey: key) else { return nil }
        return Data(referencing: object)
    }
    
}
