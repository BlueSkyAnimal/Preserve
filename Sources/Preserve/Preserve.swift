//
//  Preserve.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, visionOS 1.0, *)
public class Preserve {
    public enum Store {
        case userDefaults(UserDefaults = .standard)
        case fileManager(FileManager.SearchPathDirectory = .applicationSupportDirectory)
    }
    
    public static func save(_ value: Encodable, key name: String, to store: Store = .fileManager(.applicationSupportDirectory)) throws {
        let data = try value.encoded()
        
        switch store {
        case .userDefaults(let store):
            store.set(data, forKey: name)
        case .fileManager(let directory):
            try FileManager.save(name, data: data, directory: directory)
        }
    }
    
    public static func save(_ value: Encodable, key name: some StringProtocol, to store: Store = .fileManager(.applicationSupportDirectory)) throws {
        try save(value, key: String(name), to: store)
    }
    
    public static func save(_ value: Encodable, key name: CustomStringConvertible, to store: Store = .fileManager(.applicationSupportDirectory)) throws {
        try save(value, key: name.description, to: store)
    }
    
    public static func item<T: Codable>(
        _ type: T.Type = T.self,
        key name: String,
        from store: Store = .fileManager(.applicationSupportDirectory)
    ) throws -> T {
        let data: Data = try item(key: name, from: store)
        return try data.decoded(T.self)
    }
    
    public static func item<T: Codable>(
        _ type: T.Type = T.self,
        key name: some StringProtocol,
        from store: Store = .fileManager(.applicationSupportDirectory)
    ) throws -> T {
        try item(key: String(name), from: store)
    }
    
    public static func item<T: Codable>(
        _ type: T.Type = T.self,
        key name: CustomStringConvertible,
        from store: Store = .fileManager(.applicationSupportDirectory)
    ) throws -> T {
        try item(key: name.description, from: store)
    }
    
    public static func item(
        key name: String,
        from store: Store = .fileManager(.applicationSupportDirectory)
    ) throws -> Data {
        switch store {
        case .userDefaults(let store):
            guard let content = store.data(forKey: name) else {
                throw FileManagerError.fileNotFound
            }
            return content
        case .fileManager(let directory):
            return try FileManager.item(name, directory: directory)
        }
    }
    
    public static func item(
        key name: some StringProtocol,
        from store: Store = .fileManager(.applicationSupportDirectory)
    ) throws -> Data {
        try item(key: String(name), from: store)
    }
    
    public static func item(
        key name: CustomStringConvertible,
        from store: Store = .fileManager(.applicationSupportDirectory)
    ) throws -> Data {
        try item(key: name.description, from: store)
    }
}

