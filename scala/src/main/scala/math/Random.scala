package rays.math

import java.lang.Double.longBitsToDouble

final class Random(var seed: Long):
  def nextLong(): Long =
    seed = (6364136223846793005L * seed) + 1L
    seed

  def nextDoubleBetween(min: Double, max: Double): Double =
    val value: Double = nextLong() & Random.MAX_INT_AS_DOUBLE
    val normalized = value / Random.MAX_INT_AS_DOUBLE
    min + (max - min) * normalized

object Random:
  /// Maximum int value that can be represented as a double without loss of
  /// precision.
  val MAX_INT_AS_DOUBLE = 0x0FFFFFFFFFFFFFL
