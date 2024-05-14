package rays.existential.math

/** A half-line that extends indefinitely in one direction.
  *
  * @param origin The ray's origin.
  * @param direction The direction pointed by the ray.
  */
final case class Ray(origin: Vector3, direction: Vector3):

  /** Returns `self` with its origin translated by `delta`. */
  def translatedBy(delta: Vector3): Ray =
    Ray(origin + delta, direction)

  /** Returns `self` rotated by `alpha`. */
  def rotatedBy(alpha: Quaternion): Ray =
    Ray(origin, direction * alpha)

end Ray
