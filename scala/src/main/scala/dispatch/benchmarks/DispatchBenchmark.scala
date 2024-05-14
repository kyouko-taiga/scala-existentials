package dispatch
package benchmarks

import scala.compiletime.uninitialized

import org.openjdk.jmh.annotations.{Benchmark, BenchmarkMode, Fork, Level, Measurement, Mode as JMHMode, Param, Scope, Setup, State, Warmup}
import java.util.concurrent.TimeUnit.SECONDS

import rays.inheritance.run
import lcg.Random

@BenchmarkMode(Array(JMHMode.Throughput))
@Fork(value = 1)
@Warmup(iterations = 2, time = 5, timeUnit = SECONDS)
@Measurement(iterations = 3, time = 5, timeUnit = SECONDS)
@State(Scope.Benchmark)
class DispatchBenchmark:
  @Param(Array("2", "4", "6", "8", "10", "16", "32"))
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
      given scala.util.Random = scala.util.Random(0xACE1)
      casesValues = Array.fill(valuesCountInt)(cases.randomC(classesCountInt))
    }
    {
      given scala.util.Random = scala.util.Random(0xACE1)
      existentialValues = Array.fill(valuesCountInt)(existential.randomContainingC(classesCountInt))
    }
    {
      given scala.util.Random = scala.util.Random(0xACE1)
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
      val c = existentialValues(i)
      sum = sum + c.f()
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
