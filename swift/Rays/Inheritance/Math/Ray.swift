/// A half-line that extends indefinitely in one direction.
public struct Ray: Hashable {

  /// The ray's origin.
  public var origin: Vector3

  /// The ray's direction, as a unit vector.
  public var direction: Vector3

  /// Initializes a ray with its origin and the direction toward which it points.
  public init(origin: Vector3, direction: Vector3) {
    self.origin = origin
    self.direction = direction
  }

  /// Returns `self` with its origin translated by `delta`.
  public func translated(by delta: Vector3) -> Ray {
    .init(origin: origin + delta, direction: direction)
  }

  /// Returns `self` rotated by `alpha`.
  public func rotated(by alpha: Quaternion) -> Ray {
    .init(origin: origin, direction: direction * alpha)
  }

}
