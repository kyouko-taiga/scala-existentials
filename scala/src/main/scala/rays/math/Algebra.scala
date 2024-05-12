package rays.math

import scala.math.sqrt

/** Returns the solution of a linear equation.
  *
  * A linear equation is a first-prder polinomial equation of the form `ax + b = 0`.
  */
def solveLinear(a: Double, b: Double): Option[Double] =
  if a != 0 then Some(-b / a) else None

/** Returns the roots of a quadratric equation.
  *
  * A quadratic equation is a second-order polynomial equation of the form `ax^2 + bx + c = 0`.
  */
def solveQuatratic(a: Double, b: Double, c: Double): Option[(Double, Double)] =
  val discriminant = (b * b) - (4 * a * c)

  if discriminant == 0.0 then
    // Only one real root.
    val x = -0.5 * b / a
    Some((x, x))
  else if discriminant > 0.0 then
    val q = if b > 0.0 then
      -0.5 * (b + sqrt(discriminant))
    else
      -0.5 * (b - sqrt(discriminant))

    val x0 = q / a
    val x1 = c / q
    Some(if x0 < x1 then (x0, x1) else (x1, x0))
  else
    return None
