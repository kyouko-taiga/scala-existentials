/// A polygon defined by three vertices.
public struct Triangle: Hashable {

  /// The triangle's first vertex.
  public var a: Vector3

  /// The triangle's second vertex.
  public var b: Vector3

  /// The triangle's thrid vertex.
  public var c: Vector3

  /// Initializes a triangle with three vertices.
  public init(a: Vector3, b: Vector3, c: Vector3) {
    self.a = a
    self.b = b
    self.c = c
  }

}

extension Triangle: CollisionShape {

  public var origin: Vector3 {
    .zero
  }

  public var centroid: Vector3 {
    (a + b + c) / 3.0
  }

  public func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double? {

    // Möller-Trumbore algorithm from "Fast, Minimum Storage Ray/Triangle Intersection", 1997.

    let ab = b - a
    let ac = c - a
    let pvec = ray.direction.cross(ac)
    let det = ab.dot(pvec)

    if cullingIsEnabled && det < Double.ulpOfOne {
      // If the determinant is negative, the triangle is back-facing.
      return nil
    } else if abs(det) < Double.ulpOfOne {
      // If the determinant is close to 0, the ray is parallel to the triangle.
      return nil
    }

    let idet = 1.0 / det
    let tvec = ray.origin - a
    let u = tvec.dot(pvec) * idet
    guard (u >= 0.0) && (u <= 1.0) else { return nil }

    let qvec = tvec.cross(ab)
    let v = ray.direction.dot(qvec) * idet
    guard (v >= 0.0) && (v <= 1.0) else { return nil }

    return ac.dot(qvec) * idet
  }

}

extension Triangle: CustomStringConvertible {

  public var description: String {
    return "Triangle(a: \(a), b: \(b), c: \(c))"
  }

}
