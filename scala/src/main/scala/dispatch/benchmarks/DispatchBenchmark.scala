package dispatch
package benchmarks

import scala.compiletime.uninitialized

import org.openjdk.jmh.annotations.{Benchmark, BenchmarkMode, Fork, Level, Measurement, Mode as JMHMode, Param, Scope, Setup, State, Warmup}
import java.util.concurrent.TimeUnit.SECONDS

import rays.run
import lcg.Random

@BenchmarkMode(Array(JMHMode.Throughput))
@Fork(value = 1)
@Warmup(iterations = 2, time = 5, timeUnit = SECONDS)
@Measurement(iterations = 3, time = 5, timeUnit = SECONDS)
@State(Scope.Benchmark)
class DispatchBenchmark:
  @Param(Array("2", "8", "32"))
  var classesCount: String = uninitialized
  var classesCountInt: Int = uninitialized

  @Param(Array("100"))
  var valuesCount: String = uninitialized
  var valuesCountInt: Int = uninitialized

  var casesValues: Array[cases.C] = uninitialized
  var existentialValues: Array[Containing[existential.C]] = uninitialized
  var inheritanceValues: Array[inheritance.C] = uninitialized

  given Random = Random(0xACE1)

  @Setup(Level.Trial)
  def setup =
    classesCountInt = classesCount.toInt
    valuesCountInt = valuesCount.toInt
    {
      given Random = Random(0xACE1)
      casesValues = Array.fill(valuesCountInt)(cases.randomC(classesCountInt))
    }
    {
      given Random = Random(0xACE1)
      existentialValues = Array.fill(valuesCountInt)(existential.randomContainingC(classesCountInt))
    }
    {
      given Random = Random(0xACE1)
      inheritanceValues = Array.fill(valuesCountInt)(inheritance.randomC(classesCountInt))
    }

  @Benchmark
  def benchmarkCases =
    var sum: Double = 0
    var i: Int = 0
    while i < valuesCountInt do
      sum = sum + casesValues(i).f()
      i += 1
    sum

  @Benchmark
  def benchmarkExistential =
    var sum: Double = 0
    var i: Int = 0
    while i < valuesCountInt do
      val shape = existentialValues(i)
      sum = sum + shape.f()
      i += 1
    sum

  @Benchmark
  def benchmarkInheritance =
    var sum: Double = 0
    var i: Int = 0
    while i < valuesCountInt do
      sum = sum + inheritanceValues(i).f()
      i += 1
    sum
