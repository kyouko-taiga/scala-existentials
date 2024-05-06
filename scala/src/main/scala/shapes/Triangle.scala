package rays.shapes

import rays.math.{Ray, Vector3}
import scala.math.{abs, ulp}

/** A polygon defined by three vertices.
  *
  * @param a The triangle's first vertex.
  * @param b The triangle's second vertex.
  * @param c The triangle's third vertex.
  */
final case class Triangle(a: Vector3, b: Vector3, c: Vector3) extends CollisionShape:

  def origin: Vector3 = Vector3.zero

  def centroid: Vector3 = (a + b + c) / 3.0

  def collisionDistance(ray: Ray, cullingIsEnabled: Boolean): Option[Double] =
    // Möller-Trumbore algorithm from "Fast, Minimum Storage Ray/Triangle Intersection", 1997.
    for
      ab <- Some(b - a) // so the for-comp builds an option
      ac = c - a
      pvec = ray.direction.cross(ac)
      det = ab.dot(pvec)

      if !(cullingIsEnabled && det < ulp(1.0))
      // If the determinant is negative, the triangle is back-facing.
      if !(abs(det) < ulp(1.0))
      // If the determinant is close to 0, the ray is parallel to the triangle.

      idet = 1.0 / det
      tvec = ray.origin - a
      u = tvec.dot(pvec) * idet
      if 0.0 <= u && u <= 1.0

      qvec = tvec.cross(ab)
      v = ray.direction.dot(qvec) * idet
      if 0.0 <= v && v <= 1.0

    yield ac.dot(qvec) * idet

  /** A string representation of `this`. */
  override def toString: String =
    s"Triangle(a: ${a}, b: ${b}, c: ${c})"

end Triangle
