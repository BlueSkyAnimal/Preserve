//
//  Color+Preservable.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Color: RawRepresentable, Codable {
#if canImport(UIKit)
    public typealias SystemColor = UIColor
#elseif canImport(AppKit)
    public typealias SystemColor = NSColor
#endif
    
    public init(systemColor: SystemColor) {
        #if os(iOS)
        self = .init(uiColor: systemColor)
        #elseif os(macOS)
        self = .init(nsColor: systemColor)
        #endif
    }
    
    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: SystemColor(self), requiringSecureCoding: false)
            return String(data: data, encoding: .utf8)!
        } catch {
            print(error.localizedDescription)
            return "{}"
        }
    }
    
    public init?(rawValue: String) {
        let data = Data(rawValue.utf8)
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: SystemColor.self, from: data)!
            self = Color(color)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
