/// A collision shape with a lazy rotation.
public class Rotated<S: CollisionShape>: CollisionShape {

  /// The vertices of `self` sans translation.
  public let base: S

  /// The rotation of `self`.
  public let rotation: Quaternion

  /// Initializes an instance representing `b` rotated by `r`.
  public init(_ b: S, by r: Quaternion) {
    self.base = b
    self.rotation = r
  }

  // Returns `self` translated by `alpha`.
  public func rotated(by alpha: Quaternion) -> Rotated<S> {
    .init(base, by: rotation * alpha)
  }

  public var origin: Vector3 {
    base.origin
  }

  public var centroid: Vector3 {
    base.centroid
  }

  public func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double? {
    // let i = rotation.inverted
    let r = Ray(origin: ray.origin, direction: ray.direction * rotation)
    return base.collisionDistance(from: r, withCulling: cullingIsEnabled)
  }

}

extension Rotated: CustomStringConvertible {

  public var description: String {
    "Rotated(\(base), by: \(rotation))"
  }

}
