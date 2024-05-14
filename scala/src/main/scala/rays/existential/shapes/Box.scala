package rays.existential.shapes

import rays.existential.math.{Ray, Vector3}
import scala.math.abs

/** A rectangular cuboid centered at the origin.
  *
  * @param dimensions The dimensions of the box.
  */
final case class Box(dimensions: Vector3):

  /** The box' absolute dimension along the x-axis. */
  def width: Double = abs(dimensions.x)

  /** The box' absolute dimension along the y-axis. */
  def height: Double = abs(dimensions.y)

  /** The box' absolute dimension along the z-axis. */
  def depth: Double = abs(dimensions.z)

  /** The minimum point of the box. */
  def min: Vector3 = Vector3(-width * 0.5, -height * 0.5, -depth * 0.5)

  /// The maximum point of the box.
  def max: Vector3 = -min

  /** Returns the box with its coordinates scaled by the given factors. */
  def scaledBy(factors: Vector3): Box =
    Box(dimensions * factors)

  /** A string representation of `this`. */
  override def toString: String =
    s"Box(dimensions: ${dimensions})"

given Box is CollisionShape:
  extension (s: Box)
    def origin: Vector3 = Vector3.zero

    def centroid: Vector3 = Vector3.zero

    def collisionDistance(ray: Ray, cullingIsEnabled: Boolean): Option[Double] =
      val tmin = (s.min - ray.origin) / ray.direction
      val tmax = (s.max - ray.origin) / ray.direction

      val t = tmin.combined(tmax)(scala.math.min)
      val n = scala.math.max(scala.math.max(t.x, t.y), t.z)

      val u = tmax.combined(tmax)(scala.math.max)
      val f = scala.math.min(scala.math.min(u.x, u.y), u.z)

      if (n < f) then Some(n) else None


object Box:

  /** A box having sides of lenght 1. */
  final val unit = Box(Vector3.unitScale)

end Box
