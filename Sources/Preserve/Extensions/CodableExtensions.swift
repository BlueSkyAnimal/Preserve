//
//  CodableExtensions.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import Foundation

public protocol CodableRawRepresentable: RawRepresentable, Codable {}

extension CodableRawRepresentable {
    public var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            return String(data: try encoder.encode(self), encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
            return "{}"
        }
    }
    
    public init?(rawValue: String) {
        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(Self.self, from: Data(rawValue.utf8))
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Array: RawRepresentable where Element: CodableRawRepresentable {
    public var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            return try String(data: encoder.encode(self), encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
            return "[]"
        }
    }
    
    public init?(rawValue: String) {
        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(Self.self, from: Data(rawValue.utf8))
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Set: RawRepresentable where Element: CodableRawRepresentable {
    public var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            return try String(data: encoder.encode(self), encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
            return "[]"
        }
    }
    
    public init?(rawValue: String) {
        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(Self.self, from: Data(rawValue.utf8))
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Optional: RawRepresentable where Wrapped: CodableRawRepresentable {
    public var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            return try String(data: encoder.encode(self), encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
            return "[]"
        }
    }
    
    public init?(rawValue: String) {
        guard let value = try? JSONDecoder().decode(Self.self, from: Data(rawValue.utf8)) else {
            return nil
        }
        self = value
    }
}

extension Data {
  public func decoded<T: Codable>(_ type: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
    return try decoder.decode(T.self, from: self)
  }
}

extension Encodable {
  public func encoded(encoder: JSONEncoder = JSONEncoder()) throws -> Data {
    encoder.outputFormatting = .prettyPrinted
    return try encoder.encode(self)
  }
}
