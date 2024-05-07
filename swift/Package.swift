// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "Rays",
  platforms: [
      .macOS(.v10_15)
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
  ],
  targets: [
    .executableTarget(name: "Rays", dependencies: [
      .product(name: "Numerics", package: "swift-numerics"),
    ]),
  ])
