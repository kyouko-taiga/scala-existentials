// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "Rays",
  platforms: [
    .macOS(.v13),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
    .package(url: "https://github.com/ordo-one/package-benchmark", from: "1.23.1"),
  ],
  targets: [
    .target(
      name: "Lcg",
      dependencies: [
        .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Lcg/Lib"
    ),
    .testTarget(
      name: "LcgTests",
      dependencies: ["Lcg"],
      path: "Lcg/Tests"
    ),
    .target(
      name: "RaysExistential",
      dependencies: [
        "Lcg",
        .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Rays/Existential"
    ),
    .executableTarget(
      name: "RaysMain",
      dependencies: ["Lcg", "RaysExistential"],
      path: "Rays/Main"
    ),
    .testTarget(
      name: "RaysTests",
      dependencies: ["Lcg", "RaysExistential"],
      path: "Rays/Tests"
    ),
    .executableTarget(
      name: "RaysBenchmark",
      dependencies: [
        "RaysExistential",
        .product(name: "Benchmark", package: "package-benchmark"),
      ],
      path: "Benchmarks/RaysBenchmark",
      plugins: [
        .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
      ]
    ),
  ])
