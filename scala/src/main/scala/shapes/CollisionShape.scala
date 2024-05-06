package rays.shapes

import rays.math.{Ray, Vector3}

/** A collision shape, defining a volume for collision testing. */
trait CollisionShape:

  /** The origin of the shape's local coordinate space. */
  def origin: Vector3

  /** The arithmetic mean position of the points in the surface of self.
    *
    * Intuitively, the centroid of a shape is the "center of mass" of the shape. It is not always
    * equal to zero, which defines the local coordinate space of the shape.
    */
  def centroid: Vector3

  /** Returns the distance from `ray`'s origin to the point at which it intersects with `self`, or
    * `nil` if there is no intersection.
    *
    * @param ray The ray with which a collision will be tested.
    * @param cullingIsEnabled On side-shapes, specifies whether face culling is enabled, in which
    *   case a collision will not be detected unless the ray hits the front of the shape.
    */
  def collisionDistance(ray: Ray, cullingIsEnabled: Boolean): Option[Double]
