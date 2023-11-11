//
//  Preserve.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
public class Preserve {
  public enum Store {
    case userDefaults(UserDefaults = .standard)
    case fileManager(FileManager.SearchPathDirectory = .documentDirectory)
  }
  
  public static func save(_ value: Encodable, key name: String, to store: Store = .fileManager(.documentDirectory)) throws {
    let data = try value.encoded()
    
    switch store {
    case .userDefaults(let store):
      store.set(data, forKey: name)
    case .fileManager(let directory):
      try FileManager.save(name, data: data, directory: directory)
    }
  }
  
  public static func item<T: Codable>(_ type: T.Type = T.self, key name: String, from store: Store = .fileManager(.documentDirectory)) throws -> T {
    func data() throws -> Data {
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
    
    return try data().decoded(T.self)
  }
}

