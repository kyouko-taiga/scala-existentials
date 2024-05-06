package rays.math

import scala.math.sqrt

/** Returns the solution of a linear equation.
  *
  * A linear equation is a first-prder polinomial equation of the form `ax + b = 0`.
  */
def solveLinear(a: Double, b: Double): Option[Double] =
  Option.unless(a == 0)(-b / a)

/** Returns the roots of a quadratric equation.
  *
  * A quadratic equation is a second-order polynomial equation of the form `ax^2 + bx + c = 0`.
  */
def solveQuatratic(a: Double, b: Double, c: Double): Option[(Double, Double)] =
  val discriminant = (b * b) - (4 * a * c)
  Option.when(discriminant >= 0d):
    if discriminant == 0.0 then
      // Only one real root.
      val x = -0.5 * b / a
      (x, x)
    else
      val q = -0.5 * (b + (if b > 0d then 1 else -1) * sqrt(discriminant))
      val (x0, x1) = (q / a, c / q)
      if x0 < x1 then (x0, x1) else (x1, x0)

