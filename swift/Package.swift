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
      name: "Rays",
      dependencies: [
          .product(name: "Numerics", package: "swift-numerics"),
      ],
      path: "Sources"
    ),
    .executableTarget(
      name: "RaysMain",
      dependencies: ["Rays"],
      path: "Main"
    ),
  ])

package.targets += [
  .executableTarget(
    name: "RaysBenchmark",
    dependencies: [
      "Rays",
      .product(name: "Benchmark", package: "package-benchmark"),
    ],
    path: "Benchmarks/RaysBenchmark",
    plugins: [
      .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
    ]
  ),
]
