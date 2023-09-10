// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Preserve",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Preserve",
            targets: ["Preserve"]),
    ],
    targets: [
        .target(
            name: "Preserve"),
        .testTarget(
            name: "PreserveTests",
            dependencies: ["Preserve"]),
    ]
)
