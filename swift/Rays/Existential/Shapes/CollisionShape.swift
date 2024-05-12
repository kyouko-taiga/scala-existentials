/// A collision shape, defining a volume for collision testing.
public protocol CollisionShape {

  /// The origin of the shape's local coordinate space.
  var origin: Vector3 { get }

  /// The arithmetic mean position of the points in the surface of self.
  ///
  /// Intuitively, the centroid of a shape is the "center of mass" of the shape. It is not always
  /// equal to zero, which defines the local coordinate space of the shape.
  var centroid: Vector3 { get }

  /// Returns the distance from `ray`'s origin to the point at which it intersects with `self`, or
  /// `nil` if there is no intersection.
  ///
  /// - Parameters:
  ///   - ray: The ray with which a collision will be tested.
  ///   - cullingIsEnabled: On side-shapes, specifies whether face culling is enabled, in which
  ///     case a collision will not be detected unless the ray hits the front of the shape.
  func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double?

}

extension CollisionShape {

  /// Returns `self` translated by `delta`.
  func translated(by delta: Vector3) -> Translated<Self> {
    .init(self, by: delta)
  }

  /// Returns `self` rotated by `alpha`.
  func rotated(by alpha: Quaternion) -> Rotated<Self> {
    .init(self, by: alpha)
  }

}
