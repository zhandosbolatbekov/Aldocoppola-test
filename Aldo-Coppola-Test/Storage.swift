//
//  Storage.swift
//  Aldo-Coppola-Test
//
//  Created by Zhandos Bolatbekov on 4/25/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import Cache

private struct Caches {
    static let jsonCache = try! Cache.Storage(diskConfig: DiskConfig(name: "JSON Cache"),
                                              memoryConfig: MemoryConfig())
    static let imageCache = try! Cache.Storage(diskConfig: DiskConfig(name: "Image Cache"),
                                               memoryConfig: MemoryConfig())
}

private struct Keys {
    static let masters = "Masters"
    static let serviceGroups = "Service groups"
    static let imageUrls = "Image Urls"
    static let info = "Info"
}

struct Storage {
    static var serviceGroups: [ServiceGroup] {
        get {
            do {
                return try Caches.jsonCache.object(ofType: [ServiceGroup].self, forKey: Keys.serviceGroups)
            } catch {
                return []
            }
        }
        set {
            do {
                try Caches.jsonCache.setObject(newValue, forKey: Keys.serviceGroups)
            } catch {
                
            }
        }
    }
    static var masters: [Master] {
        get {
            do {
                return try Caches.jsonCache.object(ofType: [Master].self, forKey: Keys.masters)
            } catch {
                return []
            }
        }
        set {
            do {
                try Caches.jsonCache.setObject(newValue, forKey: Keys.masters)
            } catch {
                
            }
        }
    }
    static var imageUrls: [String] {
        get {
            do {
                return try Caches.jsonCache.object(ofType: [String].self, forKey: Keys.imageUrls)
            } catch {
                return []
            }
        }
        set {
            do {
                try Caches.jsonCache.setObject(newValue, forKey: Keys.imageUrls)
            } catch {
                
            }
        }
    }
    static var info: Info! {
        get {
            do {
                return try Caches.jsonCache.object(ofType: Info.self, forKey: Keys.info)
            } catch {
                return nil
            }
        }
        set {
            do {
                try Caches.jsonCache.setObject(newValue, forKey: Keys.info)
            } catch {
                
            }
        }
    }
    static func clear() {
        Storage.masters = []
        Storage.serviceGroups = []
        Storage.info = nil
        Storage.imageUrls = []
    }
}
