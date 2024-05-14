package dispatch
package benchmarks

import scala.compiletime.uninitialized

import org.openjdk.jmh.annotations.{Benchmark, BenchmarkMode, Fork, Level, Measurement, Mode as JMHMode, OutputTimeUnit, Param, Scope, Setup, State, Warmup}
import java.util.concurrent.TimeUnit.{MICROSECONDS, SECONDS}

import rays.inheritance.run
import lcg.Random

@BenchmarkMode(Array(JMHMode.SingleShotTime))
@Fork(value = 1)
@Warmup(iterations = 1000, time = 1, timeUnit = SECONDS)
@Measurement(iterations = 1000, time = 1, timeUnit = SECONDS)
@State(Scope.Benchmark)
@OutputTimeUnit(MICROSECONDS)
class DispatchBenchmark:
  @Param(Array("2", "4", "6", "8", "10", "12", "14", "16", "18", "20"))
  var classCount: String = uninitialized
  var classCountInt: Int = uninitialized

  @Param(Array("1000000"))
  var valueCount: String = uninitialized
  var valueCountInt: Int = uninitialized

  var casesValues: Array[cases.C] = uninitialized
  var existentialValues: Array[Containing[existential.C]] = uninitialized
  var inheritanceValues: Array[inheritance.C] = uninitialized

  given Random = Random(0xACE1)

  @Setup(Level.Trial)
  def setup =
    classCountInt = classCount.toInt
    valueCountInt = valueCount.toInt
    {
      casesValues = Array.tabulate(valueCountInt)(i => cases.randomC(i % classCountInt, i))
    }
    {
      existentialValues = Array.tabulate(valueCountInt)(i => existential.randomContainingC(i % classCountInt, i))
    }
    {
      inheritanceValues = Array.tabulate(valueCountInt)(i => inheritance.randomC(i % classCountInt, i))
    }

  /*
  @Benchmark
  def benchmarkCases =
    var sum: Double = 0
    var i: Int = 0
    while i < valueCountInt do
      sum = sum + casesValues(i).f()
      i += 1
    sum
  */

  @Benchmark
  def benchmarkExistential =
    var sum: Double = 0
    var i: Int = 0
    while i < valueCountInt do
      val c = existentialValues(i)
      sum = sum + c.f()
      i += 1
    sum

  @Benchmark
  def benchmarkInheritance =
    var sum: Double = 0
    var i: Int = 0
    while i < valueCountInt do
      sum = sum + inheritanceValues(i).f()
      i += 1
    sum
