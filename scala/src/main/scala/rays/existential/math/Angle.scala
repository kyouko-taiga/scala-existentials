package rays.existential.math

import scala.math.Pi

/** An angle.
  *
  * This structure is intended to be used as a wrapper for angle values, rather than expressing it
  * as a raw double value. The advantage is that this dispels any possible confusion between values
  * given degrees or in radians.
  *
  * @param radians The value of the angle in radians.
  */
final class Angle private (val radians: Double):

  /** The angle0s value in degrees. */
  def degrees: Double =
    radians * 180 / Pi

  /** Returns `this` wrapped within the interval `[0, 2 * pi[`. */
  def wrapped: Angle =
    var r = radians
    if r < 0 then
      while (r < 0) do r = r + 2 * Pi
    else
      while (r >= 2 * Pi) do r = r - 2 * Pi
    new Angle(r)

  /** Returns the sum of two angles. */
  def + (that: Angle): Angle =
    new Angle(radians + that.radians)

  /** Returns the subtraction of two angles. */
  def - (that: Angle): Angle =
    new Angle(radians - that.radians)

  /** Returns the multiplication of two angles. */
  def * (that: Angle): Angle =
    new Angle(radians * that.radians)

  /** Returns the division of two angles. */
  def / (that: Angle): Angle =
    new Angle(radians / that.radians)

  /** Returns `true` iff `this` is equal to `that`. */
  override def equals(that: Any): Boolean =
    that match
      case rhs: Angle => wrapped.radians == rhs.wrapped.radians
      case _ => false

  /** Returns a hash of `this`. */
  override def hashCode(): Int =
    radians.hashCode()

  override def toString(): String = s"Angle(${radians})"

object Angle:

  /** An angle equal to zero. */
  final val zero = new Angle(0)

  /** Creates an angle from its value in radians. */
  def radians(a: Double): Angle =
    new Angle(a)

  /** Creates an angle from its value in degrees. */
  def degrees(a: Double): Angle =
    new Angle(a * Pi / 180.0)

end Angle
