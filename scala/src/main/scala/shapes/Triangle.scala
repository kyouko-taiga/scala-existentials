package rays.shapes

import rays.math.{Ray, Vector3}
import scala.math.{abs, ulp}

/** A polygon defined by three vertices.
  *
  * @param a The triangle's first vertex.
  * @param b The triangle's second vertex.
  * @param c The triangle's third vertex.
  */
final case class Triangle(a: Vector3, b: Vector3, c: Vector3):

  def origin: Vector3 = Vector3.zero

  def centroid: Vector3 = (a + b + c) / 3.0

  def collisionDistance(ray: Ray, cullingIsEnabled: Boolean): Option[Double] =

    // Möller-Trumbore algorithm from "Fast, Minimum Storage Ray/Triangle Intersection", 1997.

    val ab = b - a
    val ac = c - a
    val pvec = ray.direction.cross(ac)
    val det = ab.dot(pvec)

    if cullingIsEnabled && (det < ulp(1.0)) then
      // If the determinant is negative, the triangle is back-facing.
      return None
    else if abs(det) < ulp(1.0) then
      // If the determinant is close to 0, the ray is parallel to the triangle.
      return None

    val idet = 1.0 / det
    val tvec = ray.origin - a
    val u = tvec.dot(pvec) * idet
    if (u < 0.0) || (u > 1.0) then return None

    val qvec = tvec.cross(ab)
    val v = ray.direction.dot(qvec) * idet
    if (v < 0.0) || (v > 1.0) then return None

    Some(ac.dot(qvec) * idet)

  /** A string representation of `this`. */
  override def toString: String =
    s"Triangle(a: ${a}, b: ${b}, c: ${c})"

end Triangle
