//
//  ColorScheme+Preservable.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

extension ColorScheme: Preservable {
    public var rawValue: String {
        switch self {
            case .light: "light"
            case .dark: "dark"
            @unknown default: fatalError()
        }
    }
}
