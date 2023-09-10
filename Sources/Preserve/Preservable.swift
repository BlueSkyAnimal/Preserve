//
//  Preservable.swift
//
//
//  Created by BlueSkyAnimal on 2023/09/10.
//

import SwiftUI

public protocol Preservable: CaseIterable, RawRepresentable, Codable where RawValue: Equatable {}

public extension Preservable {
    init?(rawValue: RawValue) {
        guard let matched = Self.matched(rawValue) else { return nil }
        self = matched
    }
}

public extension CaseIterable where Self: RawRepresentable, Self.RawValue: Equatable {
    static func matched(_ rawValue: RawValue) -> Self? {
        Self.allCases.first { $0.rawValue == rawValue }
    }
}
