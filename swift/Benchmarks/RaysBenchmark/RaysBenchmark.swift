// Benchmark boilerplate generated by Benchmark

import Benchmark
import Foundation
import RaysExistential
import RaysInheritance

let benchmarks = {
  let shapeCounts = [512, 1024, 2048]
  let config = Benchmark.Configuration(
      metrics: [BenchmarkMetric.wallClock],
      //warmupIterations: 10,
      maxDuration: .seconds(30)
      //maxIterations: 30
  )
  for shapeCount in shapeCounts {
    Benchmark("runExistential(shapeCount:\(shapeCount))", configuration: config) { _ in
      var world = RaysExistential.initialWorld(shapeCount: shapeCount)
      blackHole(RaysExistential.run(world: &world))
    }
  }
  for shapeCount in shapeCounts {
    Benchmark("runInheritance(shapeCount:\(shapeCount))", configuration: config) { _ in
      var world = RaysInheritance.initialWorld(shapeCount: shapeCount)
      blackHole(RaysInheritance.run(world: &world))
    }
  }
}
