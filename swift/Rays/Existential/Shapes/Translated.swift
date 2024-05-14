/// A collision shape with a lazy translation.
public struct Translated<S: CollisionShape> {

  /// The vertices of `self` sans translation.
  public let base: S

  /// The translation of `self`.
  public let translation: Vector3

  /// Initializes an instance representing `b` translated by `t`.
  public init(_ b: S, by t: Vector3) {
    self.base = b
    self.translation = t
  }

  // Returns `self` translated by `delta`.
  public func translated(by delta: Vector3) -> Translated<S> {
    .init(base, by: translation + delta)
  }

}

extension Translated: CollisionShape {

  public var origin: Vector3 {
    base.origin
  }

  public var centroid: Vector3 {
    base.centroid + translation
  }

  public func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double? {
    let r = Ray(origin: ray.origin - translation, direction: ray.direction)
    return base.collisionDistance(from: r, withCulling: cullingIsEnabled)
  }

}

extension Translated: CustomStringConvertible {

  public var description: String {
    "Translated(\(base), by: \(translation))"
  }

}
