import Benchmark
import Foundation
import DispatchInheritance
import DispatchExistential
import Lcg

let benchmarks: () -> () = {
  let classCounts: [Int] = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
  let valueCount = 1_000_000
  let config = Benchmark.Configuration(
      metrics: [BenchmarkMetric.wallClock],
      timeUnits: BenchmarkTimeUnits.microseconds,
      warmupIterations: 1000,
      maxDuration: .seconds(600),
      maxIterations: 1000
  )
  for classCount in classCounts {
    let inheritanceValues: [DispatchInheritance.C] =
      (0 ..< valueCount).map { i in DispatchInheritance.randomC(classIndex: i % classCount, value: Double(i)) }
    let existentialValues: [any DispatchExistential.C] =
      (0 ..< valueCount).map { i in DispatchExistential.randomAnyC(classIndex: i % classCount, value: Double(i)) }

    Benchmark("dispatchInheritance(classCount:\(classCount))", configuration: config) { _ in
      var sum: Double = 0
      for i in 0..<valueCount {
        sum += inheritanceValues[i].f()
      }
      blackHole(sum)
    }

    Benchmark("dispatchExistential(classCount:\(classCount))", configuration: config) { _ in
      var sum: Double = 0
      for i in 0..<valueCount {
        sum += existentialValues[i].f()
      }
      blackHole(sum)
    }
  }
}
