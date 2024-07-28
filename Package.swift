// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "Injection",
  platforms: [
    .iOS(.v14),
    .macOS(.v10_15),
    .watchOS(.v5),
    .tvOS(.v12)
  ],
  products: [
    .library(
      name: "Injection",
      targets: ["Injection"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-syntax", from: "510.0.0")
  ],
  targets: [
    .macro(name: "Macros", dependencies: [
      .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
      .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
    ]),
    .target(name: "Injection", dependencies: ["Macros"]),
    .testTarget(name: "InjectionTests", dependencies: ["Injection"]),
    .testTarget(name: "MacrosTest", dependencies: ["Macros", .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")])
  ]
)
