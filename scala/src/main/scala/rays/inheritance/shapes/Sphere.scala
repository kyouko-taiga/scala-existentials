package rays.inheritance.shapes

import rays.inheritance.math.{solveQuatratic, Ray, Vector3}

/** A sphere centered at the origin.
  *
  * @param radius The sphere's radius.
  */
final case class Sphere(radius: Double) extends CollisionShape:

  def origin: Vector3 = Vector3.zero

  def centroid: Vector3 = Vector3.zero

  def collisionDistance(ray: Ray, cullingIsEnabled: Boolean): Option[Double] =
    val l = ray.origin
    val r = radius
    val a = ray.direction.dot(ray.direction)
    val b = ray.direction.dot(l) * 2.0
    val c = l.dot(l) - (r * r)

    solveQuatratic(a, b, c).flatMap({ (x0, x1) =>
      if x0 < 0.0 then
         if (cullingIsEnabled || (x1 < 0.0)) then None else Some(x1)
      else
        Some(x0)
    })

  /** A string representation of `this`. */
  override def toString: String =
    s"Sphere(radius: ${radius})"

object Sphere:

  /** A sphere with a diameter of 1. */
  final val unit = Sphere(0.5)

end Sphere
