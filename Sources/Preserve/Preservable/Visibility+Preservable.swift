//
//  Visibility+Preservable.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Visibility: Preservable {
    public var rawValue: String {
        switch self {
            case .automatic: "automatic"
            case .visible: "visible"
            case .hidden: "hidden"
        }
    }
}
