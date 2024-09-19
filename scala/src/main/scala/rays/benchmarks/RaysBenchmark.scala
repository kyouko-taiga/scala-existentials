package rays
package benchmarks

import scala.compiletime.uninitialized

import org.openjdk.jmh.annotations.{Benchmark, BenchmarkMode, Fork, Level, Measurement, Mode as JMHMode, OutputTimeUnit, Param, Scope, Setup, State, Warmup}
import java.util.concurrent.TimeUnit.{MICROSECONDS, SECONDS}

@BenchmarkMode(Array(JMHMode.SingleShotTime))
@Fork(value = 1)
@Warmup(iterations = 2500, time = 1, timeUnit = SECONDS)
@Measurement(iterations = 2500, time = 1, timeUnit = SECONDS)
@State(Scope.Benchmark)
@OutputTimeUnit(MICROSECONDS)
class RaysBenchmark:
  @Param(Array("1000"))
  var size: String = uninitialized

  @Benchmark
  def benchmarkExistential: Unit =
    val world = existential.initialWorld(size.toInt)
    existential.run(world)

  @Benchmark
  def benchmarkInheritance: Unit =
    val world = inheritance.initialWorld(size.toInt)
    inheritance.run(world)
