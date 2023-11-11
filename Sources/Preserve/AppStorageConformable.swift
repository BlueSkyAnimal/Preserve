//
//  AppStorageConformable.swift
//
//
//  Created by BlueSkyAnimal on 2023/10/07.
//

import SwiftUI

public protocol AppStorageConformable: RawRepresentable, Codable {}

extension AppStorageConformable {
  public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let decoded = try? data.decoded(Self.self) else {
      return nil
    }
    
    self = decoded
  }
  
  public var rawValue: String {
    guard let data = try? encoded(),
          let rawValue = String(data: data, encoding: .utf8) else {
      return "{}"
    }
    
    return rawValue
  }
}

extension Array: RawRepresentable where Element: Codable {
  public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let result = try? data.decoded([Element].self)
    else { return nil }
    
    self = result
  }
  
  public var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let result = String(data: data, encoding: .utf8)
    else { return "[]" }
    
    return result
  }
}

@available(iOS 16, macOS 13, watchOS 9, tvOS 16, xrOS 1, *)
extension LocalizedStringResource: AppStorageConformable {}
