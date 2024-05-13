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
  @Param(Array("512", "1024", "2048"))
  var sizeString: String = uninitialized

  var size: Int = uninitialized

  @Setup(Level.Trial)
  def setup =
    size = sizeString.toInt

  @Benchmark
  def benchmarkExistential: Unit = existential.run(size)

  @Benchmark
  def benchmarkInheritance: Unit = inheritance.run(size)
