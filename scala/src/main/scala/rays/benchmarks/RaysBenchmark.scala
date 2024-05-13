package rays
package benchmarks

import scala.compiletime.uninitialized

import org.openjdk.jmh.annotations.{Benchmark, BenchmarkMode, Fork, Level, Measurement, Mode as JMHMode, Param, Scope, Setup, State, Warmup}
import java.util.concurrent.TimeUnit.SECONDS

@BenchmarkMode(Array(JMHMode.AverageTime))
@Fork(value = 2)
@Warmup(iterations = 4, time = 5, timeUnit = SECONDS)
@Measurement(iterations = 4, time = 5, timeUnit = SECONDS)
@State(Scope.Benchmark)
class RaysBenchmark:
  @Param(Array("512", "2048"))
  var size: String = uninitialized

  @Benchmark
  def benchmarkExistential: Unit =
    val world = existential.initialWorld(size.toInt)
    existential.run(world)

  @Benchmark
  def benchmarkInheritance: Unit =
    val world = inheritance.initialWorld(size.toInt)
    inheritance.run(world)
