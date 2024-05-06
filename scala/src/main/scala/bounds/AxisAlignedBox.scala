package rays.bounds

import rays.math.Vector3
import scala.math.abs

/** The location and dimensions of a box (a.k.a. rectangular cuboid).
  *
  * @param origin The box's origin (e.g., its front-bottom-left corner).
  * @param dimensions The box's dimensions.
  */
final case class AxisAlignedBox(origin: Vector3, dimensions: Vector3):

  /** The box' smallest x-coordinate. */
  def minX: Double = origin.x + (dimensions.x min 0)

  /** The box' smallest y-coordinate. */
  def minY: Double = if (dimensions.y > 0.0) then origin.y else (origin.y + dimensions.y)

  /** The box' smallest z-coordinate. */
  def minZ: Double = if (dimensions.z > 0.0) then origin.z else (origin.z + dimensions.z)

  /** The box' greatest x-coordinate. */
  def maxX: Double = if (dimensions.x > 0.0) then (origin.x + dimensions.x) else origin.x

  /** The box' greatest y-coordinate. */
  def maxY: Double = if (dimensions.y > 0.0) then (origin.y + dimensions.y) else origin.y

  /** The box' greatest z-coordinate. */
  def maxZ: Double = if (dimensions.z > 0.0) then (origin.z + dimensions.z) else origin.z

  /** The box' absolute dimension along the x-axis. */
  def width: Double = abs(dimensions.x)

  /** The box' absolute dimension along the y-axis. */
  def height: Double = abs(dimensions.y)

  /** The box' absolute dimension along the z-axis. */
  def depth: Double = abs(dimensions.z)

  /** Returns the box whose coordinates are scaled by the given factors.
    *
    * All coordinates are scaled, meaning that the new box will not have the same if the this box'
    * origin is not zero.
    *
    * @param factors The scaling factors represented as a vector whose each component scales
    *   the box' coordinates along the corresponding aixs.
    */
  def scaledBy(factors: Vector3): AxisAlignedBox =
    AxisAlignedBox(origin * factors, dimensions * factors)

  /** A string representation of `this`. */
  override def toString: String =
    s"AxisAlignedBox(origin: ${origin}, dimensions: ${dimensions})"

object AxisAlignedBox:

  /** A cube centered at the origin and having sides of lenght 1. */
  final val unit = AxisAlignedBox(Vector3.zero, Vector3.unitScale)

  def centeredAt(center: Vector3, dimensions: Vector3 = Vector3.unitScale): AxisAlignedBox =
    val origin = Vector3(
      center.x - dimensions.x / 2.0,
      center.y - dimensions.y / 2.0,
      center.z - dimensions.z / 2.0)
    AxisAlignedBox(origin, dimensions)

end AxisAlignedBox
