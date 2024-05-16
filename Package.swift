// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Injection",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .watchOS(.v5),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "Injection",
            targets: ["Injection"]),
    ],
    targets: [
        .target(
            name: "Injection"),
        .testTarget(
            name: "InjectionTests",
            dependencies: ["Injection"]),
    ]
)
