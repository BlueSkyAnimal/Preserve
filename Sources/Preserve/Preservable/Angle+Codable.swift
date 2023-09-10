//
//  Angle+Codable.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

extension Angle: Codable {
    private enum CodingKeys: CodingKey {
        case degrees, radians
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if degrees != nil {
            try container.encode(degrees, forKey: .degrees)
        } else if radians != nil {
            try container.encode(radians, forKey: .radians)
        } else {
            throw EncodingError.invalidValue(self, .init(codingPath: [], debugDescription: "Angle value is not set."))
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let degrees = try container.decodeIfPresent(Double.self, forKey: .degrees) {
            self.init(degrees: degrees)
        } else if let radians = try container.decodeIfPresent(Double.self, forKey: .radians) {
            self.init(radians: radians)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .degrees, in: container, debugDescription: "Angle value is not found.")
        }
    }
}
