import Numerics

/// A 3-dimensional vector.
///
/// 3D vectors are represented as distances along three orthogonal axes (x, y and z). They are used
/// for a variety of purposes (e.g., to describe positions, directions, scale factors, etc.). Thus,
/// the meaning of each component should be interpreted based on the context.
public struct Vector3: Hashable {

  /// The vector's x-component.
  public var x: Double

  /// The vector's y-component.
  public var y: Double

  /// The vector's z-component.
  public var z: Double

  /// Initializes a vector with components specified as floating-point values.
  public init(x: Double, y: Double, z: Double) {
    self.x = x
    self.y = y
    self.z = z
  }

  /// The vector's magnitude (a.k.a. length or norm).
  public var magnitude: Double {
    Double.sqrt(x * x + y * y + z * z)
  }

  /// The vector's squared magnitude.
  public var squaredMagnitude: Double {
    x * x + y * y + z * z
  }

  /// The vector, normalized.
  public var normalized: Vector3 {
    let l = magnitude
    return (l != 0.0) ? (self / l) : self
  }

  /// Returns the dot (a.k.a. scalar) product of `self` with `other`.
  public func dot(_ other: Vector3) -> Double {
    x * other.x + y * other.y + z * other.z
  }

  /// Computes the cross (a.k.a. vector) product of `self` vector with `other`.
  ///
  /// The cross product of two vectors `v`and `u` is a vector that is perpendicular to both `v` and
  /// `u` and thus normal to the plane containing them.
  public func cross(_ other: Vector3) -> Vector3 {
    .init(
      x: y * other.z - z * other.y,
      y: z * other.x - x * other.z,
      z: x * other.y - y * other.x)
  }

  /// Returns the Euclidean distance between `self` and `other`.
  public func distance(to other: Vector3) -> Double {
    (other - self).magnitude
  }

  /// Returns the squared Euclidean distance between `self` and `other`.
  public func squaredDistance(to other: Vector3) -> Double {
    (other - self).squaredMagnitude
  }

  /// Returns component-wise application of `combine` on the elements of `self` and `other`.
  public func combined(
    with other: Vector3, applying combine: (Double, Double) throws -> Double
  ) rethrows -> Vector3 {
    try .init(x: combine(x, other.x), y: combine(y, other.y), z: combine(z, other.z))
  }

  /// Returns the component-wise addition of two vectors.
  public static func + (lhs: Vector3, rhs: Vector3) -> Vector3 {
    .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
  }

  /// Computes the component-wise addition of two vectors and stores the result in `lhs`.
  public static func += (lhs: inout Vector3, rhs: Vector3) {
    lhs.x += rhs.x
    lhs.y += rhs.y
    lhs.z += rhs.z
  }

  /// Returns the component-wise subtraction of two vectors.
  public static func - (lhs: Vector3, rhs: Vector3) -> Vector3 {
    .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
  }

  /// Computes the component-wise subtraction of two vectors and stores the result in `lhs`.
  public static func -= (lhs: inout Vector3, rhs: Vector3) {
    lhs.x -= rhs.x
    lhs.y -= rhs.y
    lhs.z -= rhs.z
  }

  /// Computes the additive opposite of a vector.
  prefix public static func - (operand: Vector3) -> Vector3 {
    .init(x: -operand.x, y: -operand.y, z: -operand.z)
  }

  /// Returns the component-wise multiplication of two vectors.
  public static func * (lhs: Vector3, rhs: Vector3) -> Vector3 {
    .init(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
  }

  /// Computes the component-wise multiplication of two vectors and stores the result in `lhs`.
  public static func *= (lhs: inout Vector3, rhs: Vector3) {
    lhs.x *= rhs.x
    lhs.y *= rhs.y
    lhs.z *= rhs.z
  }

  /// Returns the multiplication of a vector by a scalar.
  public static func * (lhs: Vector3, rhs: Double) -> Vector3 {
    .init(x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
  }

  /// Computes the multiplication of a vector by a scalar and stores the result in `lhs`.
  public static func *= (lhs: inout Vector3, rhs: Double) {
    lhs.x *= rhs
    lhs.y *= rhs
    lhs.z *= rhs
  }

  /// Returns the component-wise division of two vectors.
  public static func / (lhs: Vector3, rhs: Vector3) -> Vector3 {
    .init(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
  }

  /// Computes the component-wise division of two vectors and stores the result in `lhs`.
  public static func /= (lhs: inout Vector3, rhs: Vector3) {
    lhs.x /= rhs.x
    lhs.y /= rhs.y
    lhs.z /= rhs.z
  }

  /// Returns the division of a vector by a scalar.
  public static func / (lhs: Vector3, rhs: Double) -> Vector3 {
    .init(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
  }

  /// Computes the division of a vector by a scalar and stores the result in `lhs`.
  public static func /= (lhs: inout Vector3, rhs: Double) {
    lhs.x /= rhs
    lhs.y /= rhs
    lhs.z /= rhs
  }

  /// A vector whose 3 components are zero.
  public static let zero = Vector3(x: 0.0, y: 0.0, z: 0.0)

  /// A vector whose 3 components are one.
  public static let unitScale = Vector3(x: 1.0, y: 1.0, z: 1.0)

  /// A vector whose x-component is one and other components are zero.
  public static let unitX = Vector3(x: 1.0, y: 0.0, z: 0.0)

  /// A vector whose y-component is one and other components are zero.
  public static let unitY = Vector3(x: 0.0, y: 1.0, z: 0.0)

  /// A vector whose z-component is one and other components are zero.
  public static let unitZ = Vector3(x: 0.0, y: 0.0, z: 1.0)

  /// Returns a random point contained in `bounds`.
  public static func random(rand: inout Random, in bounds: AxisAlignedBox) -> Vector3 {
    .init(
      x: rand.nextDoubleBetween(min: bounds.minX, max: bounds.maxX),
      y: rand.nextDoubleBetween(min: bounds.minY, max: bounds.maxY),
      z: rand.nextDoubleBetween(min: bounds.minZ, max: bounds.maxZ))
  }

}

extension Vector3: CustomStringConvertible {

  public var description: String {
    "(\(x), \(y), \(z))"
  }

}
