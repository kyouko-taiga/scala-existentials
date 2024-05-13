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
      name: "DispatchExistential",
      dependencies: [
        "Lcg",
        .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Dispatch/Existential"
    ),
    .target(
      name: "DispatchInheritance",
      dependencies: [
        "Lcg",
        .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Dispatch/Inheritance"
    ),
    .executableTarget(
      name: "DispatchBenchmark",
      dependencies: [
        "DispatchInheritance",
        "DispatchExistential",
        .product(name: "Benchmark", package: "package-benchmark"),
      ],
      path: "Benchmarks/DispatchBenchmark",
      plugins: [
        .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
      ]
    ),
    .target(
      name: "RaysExistential",
      dependencies: [
        "Lcg",
        .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Rays/Existential"
    ),
    .target(
      name: "RaysInheritance",
      dependencies: [
        "Lcg",
        .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Rays/Inheritance"
    ),
    .executableTarget(
      name: "RaysMain",
      dependencies: ["Lcg", "RaysExistential"],
      path: "Rays/Main"
    ),
    .testTarget(
      name: "RaysTests",
      dependencies: ["Lcg", "RaysExistential", "RaysInheritance"],
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
