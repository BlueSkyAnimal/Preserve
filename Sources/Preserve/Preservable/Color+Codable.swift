//
//  Color+Preservable.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, xrOS 1.0, *)
extension Color: Codable {
#if canImport(UIKit)
    typealias SystemColor = UIColor
#elseif canImport(AppKit)
    typealias SystemColor = NSColor
#endif
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let systemColor = SystemColor(self)
        let colorData = try NSKeyedArchiver.archivedData(withRootObject: systemColor, requiringSecureCoding: false)
        try container.encode(colorData)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let colorData = try container.decode(Data.self)
        guard let systemColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: SystemColor.self, from: colorData) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to decode Color.")
        }
        self.init(systemColor)
    }
}
