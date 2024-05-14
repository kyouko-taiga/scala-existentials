/// A sphere centered at the origin.
public struct Sphere {

  /// The sphere's radius.
  public var radius: Double

  /// Initializes a sphere with its radius.
  public init(radius: Double) {
    self.radius = radius
  }

  /// A sphere with a diameter of 1.
  public static var unit = Sphere(radius: 0.5)

}

extension Sphere: CollisionShape {

  public var origin: Vector3 {
    .zero
  }

  public var centroid: Vector3 {
    .zero
  }

  public func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double? {
    let l = ray.origin
    let r = radius
    let a = ray.direction.dot(ray.direction)
    let b = ray.direction.dot(l) * 2.0
    let c = l.dot(l) - (r * r)

    guard let (x0, x1) = solveQuatratic(a: a, b: b, c: c) else { return nil }

    if x0 < 0.0 {
      return (cullingIsEnabled || (x1 < 0.0)) ? nil : x1
    } else {
      return x0
    }
  }

}

extension Sphere: CustomStringConvertible {

  public var description: String {
    "Sphere(radius: \(radius))"
  }

}
