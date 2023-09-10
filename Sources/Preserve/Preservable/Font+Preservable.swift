//
//  Font+Preservable.swift
//  
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

extension Font.Weight: Preservable {
    public static var allCases: [Font.Weight] = [
        .ultraLight, .thin, .light, .regular, .medium, .semibold, .bold, .heavy, .black
    ]
    
    public var rawValue: String {
        switch self {
            case .ultraLight: "Ultralight"
            case .thin: "Thin"
            case .light: "Light"
            case .regular: "Regular"
            case .medium: "Medium"
            case .semibold: "Semibold"
            case .bold: "Bold"
            case .heavy: "Heavy"
            case .black: "Black"
            default: fatalError()
        }
    }
}

extension Font.Design: Preservable {
    public static var allCases: [Font.Design] = [
        .default, .serif, .rounded, .monospaced
    ]
    
    public var rawValue: String {
        switch self {
            case .default: "Default"
            case .serif: "Serif"
            case .rounded: "Rounded"
            case .monospaced: "Monospaced"
            @unknown default: fatalError()
        }
    }
}
