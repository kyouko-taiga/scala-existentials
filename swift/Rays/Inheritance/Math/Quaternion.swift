import Numerics

/// A 4-component hyper-complex number used for 3D rotations and orientations.
public struct Quaternion: Hashable {

  /// The quaternion's w-component.
  public var w: Double

  /// The quaternion's x-component.
  public var x: Double

  /// The quaternion's y-component.
  public var y: Double

  /// The quaternion's z-component.
  public var z: Double

  /// Initializes a quaternion with components specified as floating-point values.
  public init(w: Double, x: Double, y: Double, z: Double) {
    self.w = w
    self.x = x
    self.y = y
    self.z = z
  }

  /// Initializes a unit quaternion from an axis-angle representation.
  ///
  /// - Parameters:
  ///   - axis: The rotation axis as a normalized 3D vector.
  ///   - angle: The magnitude of rotation.
  public init(axis: Vector3, angle: Angle) {
    let halfAngle = angle.radians * 0.5
    let s = Double.sin(halfAngle)

    self.w = Double.cos(halfAngle)
    self.x = axis.x * s
    self.y = axis.y * s
    self.z = axis.z * s
  }

  /// Initializes a unit quaternion from Euler angles.
  ///
  /// The rotations are combined following a yaw (Z), then pitch (Y), then roll (X) order.
  ///
  /// - Parameters:
  ///   - yaw: The yaw angle.
  ///   - pitch: The pitch angle.
  ///   - roll: The roll angle.
  public init(yaw: Angle, pitch: Angle, roll: Angle) {
    let cy = Double.cos(yaw.radians * 0.5)
    let sy = Double.sin(yaw.radians * 0.5)
    let cp = Double.cos(pitch.radians * 0.5)
    let sp = Double.sin(pitch.radians * 0.5)
    let cr = Double.cos(roll.radians * 0.5)
    let sr = Double.sin(roll.radians * 0.5)

    self.w = cr * cp * cy + sr * sp * sy
    self.x = sr * cp * cy - cr * sp * sy
    self.y = cr * sp * cy + sr * cp * sy
    self.z = cr * cp * sy - sr * sp * cy
  }

  /// Initializes a unit quaternion from a rotation matrix.
  public init(rotation: Matrix4) {
    let trace = rotation[0,0] + rotation[1,1] + rotation[2,2]

    if trace > 0.0 {
      var root = Double.sqrt(trace + 1.0)
      self.w = root / 2.0
      root = 0.5 / root

      self.x = (rotation[2,1] - rotation[1,2]) * root
      self.y = (rotation[0,2] - rotation[2,0]) * root
      self.z = (rotation[1,0] - rotation[0,1]) * root
    } else {
      var i = 0
      if (rotation[1,1] > rotation[0,0]) {
        i = 1
      }
      if (rotation[2,2] > rotation[i,i]) {
        i = 2
      }
      let j = (i + 1) % 3
      let k = (j + 1) % 3

      var root = Double.sqrt(rotation[i,i] - rotation[j,j] - rotation[k,k] + 1.0)

      self = .zero
      withUnsafeTemporaryAllocation(of: Double.self, capacity: 3) { (components) in
        components.initialize(repeating: 0.0)
        components[i] = 0.5 * root
        root = 0.5 / root
        components[j] = (rotation[j,i] + rotation[i,j]) * root
        components[k] = (rotation[k,i] + rotation[i,k]) * root
        
        self.w = (rotation[k,j] - rotation[j,k]) * root
        self.x = components[0]
        self.y = components[1]
        self.z = components[2]
      }
    }
  }

  /// Initializes a unit quaternion representing the rotation from one vector to another.
  ///
  /// This initializer calculates a quaternion `q` such that `q * v = u`.
  ///
  /// - Parameters:
  ///   - v: A vector.
  ///   - u: The vector obtained by applying the computed rotation.
  public init(from v: Vector3, to u: Vector3, up: Vector3 = .unitY) {
    let cos2Theta = v.dot(u)
    let vu = v.cross(u)
    let w = 1.0 + cos2Theta
    let l = Double.sqrt(w * w + vu.x * vu.x + vu.y * vu.y + vu.z * vu.z)

    self.w = w / l
    self.x = vu.x / l
    self.y = vu.y / l
    self.z = vu.z / l
  }

  /// The quaternion's magnitude (a.k.a. length or norm).
  public var magnitude: Double {
    Double.sqrt(w * w + x * x + y * y + z * z)
  }

  /// The quaternion's squared magnitude.
  public var squaredMagnitude: Double {
    w * w + x * x + y * y + z * z
  }

  /// This quaternion, normalized.
  public var normalized: Quaternion {
    let l = magnitude
    return (l != 0.0) ? (self / l) : self
  }

  /// This quaternion, inverted.
  public var inverted: Quaternion {
    let s = squaredMagnitude
    if s != 0.0 {
      let i = 1.0 / s
      return Quaternion(w: w * i, x: -x * i, y: -y * i, z: -z * i)
    } else {
      return self
    }
  }

  /// The axis-angle representation of the rotation represented by this quaternion.
  public var axisAngle: (axis: Vector3, angle: Angle) {
    get {
      let angle = Angle(radians: 2.0 * Double.acos(w))

      let d = Double.sqrt(1.0 - w * w)
      if d > 0.0 {
        return (axis: Vector3(x: x / d, y: y / d, z: z / d), angle: angle)
      } else {
        // The angle is null, so any normalized axis will do.
        return (axis: Vector3.unitX, angle: angle)
      }
    }

    set {
      self = Quaternion(axis: newValue.axis, angle: newValue.angle)
    }
  }

  /// The local yaw (i.e., z-axis rotation) element of this quaternion.
  public var yaw: Angle {
    let sycp = 2.0 * (w * z + x * y)
    let cycp = 1.0 - 2.0 * (y * y + z * z)
    return Angle(radians: Double.atan2(y: sycp, x: cycp))
  }

  /// The local pitch (i.e., y-axis rotation) element of this quaternion.
  public var pitch: Angle {
    let sp = 2.0 * (w * y + x * z)
    let rd = abs(sp) >= 1
      ? Double(signOf: sp, magnitudeOf: Double.pi / 2)
      : Double.asin(sp)
    return Angle(radians: rd)
  }

  /// The local roll (i.e., x-axis rotation) element of this quaternion.
  public var roll: Angle {
    let srcp = 2.0 * (w * x + y * z)
    let crcp = 1.0 - 2.0 * (x * x + y * y)
    return Angle(radians: Double.atan2(y: srcp, x: crcp))
  }

  /// The rotation represented by this quaternion, as a transformation matrix.
  public var transform: Matrix4 {
    get {
      let x2 = x + x
      let y2 = y + y
      let z2 = z + z

      let lengthSquared = w * w + x * x + y * y + z * z
      let wx = w * x2 / lengthSquared
      let wy = w * y2 / lengthSquared
      let wz = w * z2 / lengthSquared
      let xx = x * x2 / lengthSquared
      let xy = x * y2 / lengthSquared
      let xz = x * z2 / lengthSquared
      let yy = y * y2 / lengthSquared
      let yz = y * z2 / lengthSquared
      let zz = z * z2 / lengthSquared

      var result = Matrix4.zero

      result[0,0] = 1.0 - (yy + zz)
      result[1,0] = xy + wz
      result[2,0] = xz - wy
      result[0,1] = xy - wz
      result[1,1] = 1.0 - (xx + zz)
      result[2,1] = yz + wx
      result[0,2] = xz + wy
      result[1,2] = yz - wx
      result[2,2] = 1.0 - (xx + yy)
      result[3,3] = 1.0

      return result
    }

    set {
      self = Quaternion(rotation: newValue)
    }
  }

  /// Returns the dot (a.k.a. scalar) product of `self` with `other`.
  public func dot(_ other: Quaternion) -> Double {
    w * other.w + x * other.x + y * other.y + z * other.z
  }

  /// Computes the normalized linear interpolation (nlerp) between this quaternion and another.
  ///
  /// - Parameters:
  ///   - other: The other quaternion between which compute the interpolation.
  ///   - distance: The distance from this quaternion to the other, in the range `[0, 1]`.
  public func nlrep(with other: Quaternion, distance: Double) -> Quaternion {
    (self + (other - self) * distance).normalized
  }

  /// Computes the spherical linear interpolation (slerp) between this quaternion and another.
  ///
  /// - Parameters:
  ///   - other: The other quaternion between which compute the interpolation.
  ///   - distance: The distance from this quaternion to the other, in the range `[0, 1]`.
  public func slerp(with other: Quaternion, distance: Double) -> Quaternion {
    let cosHalfTheta = dot(other)
    if cosHalfTheta < 0.95 {
      // Standard case (slerp)
      let sinHalfTheta = Double.sqrt(1.0 - cosHalfTheta * cosHalfTheta)
      let angle = Double.atan2(y: sinHalfTheta, x: cosHalfTheta)
      let coef0 = Double.sin((1.0 - distance) * angle) / sinHalfTheta
      let coef2 = Double.sin(distance * angle) / sinHalfTheta
      return self * coef0 + other * coef2
    } else {
      // There are two situations here:
      // - `self` and `other` are very close, so a linear interpolation is safe.
      // - `self` and `other` are almost inverse of each other, thus there is an infinite number of
      //   possible interpolations. Since we don't have a strategy to solve this situation, we may
      //   as well get away with a linear interpolation.
      return nlrep(with: other, distance: distance)
    }
  }

  /// Returns the component-wise addition of two quaternions.
  public static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    .init(w: lhs.w + rhs.w, x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
  }

  /// Computes the component-wise addition of two quaternions and stores the result in `lhs`.
  public static func += (lhs: inout Quaternion, rhs: Quaternion) {
    lhs.w += rhs.w
    lhs.x += rhs.x
    lhs.y += rhs.y
    lhs.z += rhs.z
  }

  /// Returns the component-wise subtraction of two quaternions.
  public static func - (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
    .init(w: lhs.w - rhs.w, x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
  }

  /// Computes the component-wise subtraction of two quaternions and stores the result in `lhs`.
  public static func -= (lhs: inout Quaternion, rhs: Quaternion) {
    lhs.w -= rhs.w
    lhs.x -= rhs.x
    lhs.y -= rhs.y
    lhs.z -= rhs.z
  }

  /// Returns the multiplication of two quaternions.
  ///
  /// If `q` and `r` are unit quaternions, then their multiplication is the composition (a.k.a.
  /// concatenation) of the rotation they represent.
  ///
  /// This operation is not commutative. There are pairs of quaternions for which `q * r != r * q`.
  public static func * (q: Quaternion, r: Quaternion) -> Quaternion {
    .init(
      w: q.w * r.w - q.x * r.x - q.y * r.y - q.z * r.z,
      x: q.w * r.x + q.x * r.w + q.y * r.z - q.z * r.y,
      y: q.w * r.y + q.y * r.w + q.x * r.z - q.z * r.x,
      z: q.w * r.z + q.z * r.w + q.x * r.y - q.y * r.x)
  }

  /// Returns the multiplication of two quaternions and stores the result in `lhs`.
  public static func *= (lhs: inout Quaternion, rhs: Quaternion) {
    lhs.w *= rhs.w
    lhs.x *= rhs.x
    lhs.y *= rhs.y
    lhs.z *= rhs.z
  }

  /// Returns the rotation of a vector by a quaternion.
  public static func * (v: Vector3, q: Quaternion) -> Vector3 {
    // nVidia SDK implementation
    let qvec = Vector3(x: q.x, y: q.y, z: q.z)
    var uv = qvec.cross(v)
    var uuv = qvec.cross(uv)
    uv = uv * (2.0 * q.w)
    uuv = uuv * 2.0
    return v + uv + uuv
  }

  /// Returns the multiplication of a quaternion by a scalar.
  public static func * (lhs: Quaternion, rhs: Double) -> Quaternion {
    .init(w: lhs.w * rhs, x: lhs.x * rhs, y: lhs.y * rhs, z: lhs.z * rhs)
  }

  /// Computes the multiplication of a quaternion by a scalar and stores the result in `lhs`.
  public static func *= (lhs: inout Quaternion, rhs: Double) {
    lhs.w *= rhs
    lhs.x *= rhs
    lhs.y *= rhs
    lhs.z *= rhs
  }

  /// Returns the division of a quaternion by a scalar.
  public static func / (lhs: Quaternion, rhs: Double) -> Quaternion {
    .init(w: lhs.w / rhs, x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
  }

  /// Computes the division of a quaternion by a scalar and stores the result in `lhs`.
  ///
  /// - Parameters:
  ///   - lhs: The quaternion to divide.
  ///   - rhs: A scalar value.
  public static func /= (lhs: inout Quaternion, rhs: Double) {
    lhs.w /= rhs
    lhs.x /= rhs
    lhs.y /= rhs
    lhs.z /= rhs
  }

  /// A quaternion whose 4 components are zero.
  public static let zero = Quaternion(w: 0.0, x: 0.0, y: 0.0, z: 0.0)

  /// A unit quaternion representing the identity rotation.
  public static let identity = Quaternion(w: 1.0, x: 0.0, y: 0.0, z: 0.0)

}

extension Quaternion: CustomStringConvertible {

  public var description: String {
    "(roll: \(roll.degrees), pitch: \(pitch.degrees), yaw: \(yaw.degrees))"
  }

}
