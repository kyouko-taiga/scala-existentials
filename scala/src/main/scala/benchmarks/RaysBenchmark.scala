package benchmarks

import scala.compiletime.uninitialized
import scala.util.Random

import org.openjdk.jmh.annotations.{Benchmark, BenchmarkMode, Fork, Level, Measurement, Mode as JMHMode, Param, Scope, Setup, State, Warmup}
import java.util.concurrent.TimeUnit.SECONDS

import rays.run

@Fork(value = 2)
@Warmup(iterations = 5, time = 1, timeUnit = SECONDS)
@Measurement(iterations = 5, time = 1, timeUnit = SECONDS)
@State(Scope.Benchmark)
class RaysBenchmark:
  @Param(Array("100", "1000"))
  var sizeString: String = uninitialized

  var size: Int = uninitialized

  given Random = Random(42)

  @Setup(Level.Trial)
  def setup =
    size = sizeString.toInt

  @Benchmark
  def benchmark: Unit = run(size)
