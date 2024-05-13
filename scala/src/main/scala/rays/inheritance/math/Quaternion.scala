package rays.inheritance.math

import scala.math.{abs, acos, asin, atan2, sqrt, cos, sin, Pi}

/** A 4-component hyper-complex number used for 3D rotations and orientations.
  *
  * @param w The quaternion's w-component.
  * @param x The quaternion's x-component.
  * @param y The quaternion's y-component.
  * @param z The quaternion's z-component.
  */
final case class Quaternion(w: Double, x: Double, y: Double, z: Double):

  /** The quaternion's magnitude (a.k.a. length or norm). */
  def magnitude: Double =
    sqrt(w * w + x * x + y * y + z * z)

  /** The quaternion's squared magnitude.
    *
    * Use this property rather than `magnitude` if you do not need the exact magnitude of the
    * quaternion, but just want know if it is `0` or if it is longer than another quaternion's.
    */
  def squaredMagnitude: Double =
    w * w + x * x + y * y + z * z

  /** The quaternion, normalized. */
  def normalized: Quaternion =
    val l = magnitude
    if l != 0.0 then this / l else this

  /** The quaternion, inverted. */
  def inverted: Quaternion =
    val s = squaredMagnitude
    if s != 0.0 then
      val i = 1.0 / s
      Quaternion(w * i, -x * i, -y * i, -z * i)
    else
      this

  /** The axis-angle representation of the rotation represented by this quaternion. */
  def axisAngle: (Vector3, Angle) =
    val a = Angle.radians(2.0 * acos(w))
    val d = sqrt(1.0 - w * w)
    if d > 0.0 then
      (Vector3(x / d, y / d, z / d), a)
    else
      // The angle is null, so any normalized axis will do.
      return (Vector3.unitX, a)

  /** The local yaw (i.e., z-axis rotation) element of this quaternion. */
  def yaw: Angle =
    val sycp = 2.0 * (w * z + x * y)
    val cycp = 1.0 - 2.0 * (y * y + z * z)
    Angle.radians(atan2(sycp, cycp))

  /** The local pitch (i.e., y-axis rotation) element of this quaternion. */
  def pitch: Angle =
    val sp = 2.0 * (w * y + x * z)
    if abs(sp) >= 1 then
      Angle.radians(if sp > 0 then (Pi / 2) else -(Pi / 2))
    else
      Angle.radians(asin(sp))

  /** The local roll (i.e., x-axis rotation) element of this quaternion. */
  def roll: Angle =
    val srcp = 2.0 * (w * x + y * z)
    val crcp = 1.0 - 2.0 * (x * x + y * y)
    Angle.radians(atan2(srcp, crcp))

  /** Returns the dot (a.k.a. scalar) product of `this` with `that`. */
  def dot(that: Quaternion): Double =
    w * that.w + x * that.x + y * that.y + z * that.z

  /** Computes the normalized linear interpolation (nlerp) between this quaternion and another.
    *
    * @param that The other quaternion between which compute the interpolation.
    * @param distance The distance from this quaternion to the other, in the range `[0, 1]`.
    */
  def nlrep(that: Quaternion, distance: Double): Quaternion =
    (this + (that - this) * distance).normalized

  /** Computes the spherical linear interpolation (slerp) between this quaternion and another.
    *
    * @param other: The other quaternion between which compute the interpolation.
    * @param distance: The distance from this quaternion to the other, in the range `[0, 1]`.
    */
  def slerp(that: Quaternion, distance: Double): Quaternion =
    val cosHalfTheta = dot(that)
    if cosHalfTheta < 0.95 then
      // Standard case (slerp)
      val sinHalfTheta = sqrt(1.0 - cosHalfTheta * cosHalfTheta)
      val angle = atan2(sinHalfTheta, cosHalfTheta)
      val coef0 = sin((1.0 - distance) * angle) / sinHalfTheta
      val coef2 = sin(distance * angle) / sinHalfTheta
      this * coef0 + that * coef2
    else
      // There are two situations here:
      // - `self` and `other` are very close, so a linear interpolation is safe.
      // - `self` and `other` are almost inverse of each other, thus there is an infinite number of
      //   possible interpolations. Since we don't have a strategy to solve this situation, we may
      //   as well get away with a linear interpolation.
      nlrep(that, distance)

  /** Returns the component-wise addition of two quaternions. */
  def + (that: Quaternion): Quaternion =
    Quaternion(w + that.w, x + that.x, y + that.y, z + that.z)

  /** Returns the component-wise subtraction of two quaternions. */
  def - (that: Quaternion): Quaternion =
    Quaternion(w - that.w, x - that.x, y - that.y, z - that.z)

  /** Returns the multiplication of two quaternions.
    *
    * If `this` and `that` are unit quaternions, then their multiplication is the composition (a.k.a.
    * concatenation) of the rotation they represent.
    *
    * This operation is not commutative. There exist pairs of quaternions `q`, `r` such that
    * `q * r != r * q`.
    */
  def * (that: Quaternion): Quaternion =
    Quaternion(
      w * that.w - x * that.x - y * that.y - z * that.z,
      w * that.x + x * that.w + y * that.z - z * that.y,
      w * that.y + y * that.w + x * that.z - z * that.x,
      w * that.z + z * that.w + x * that.y - y * that.x)

  /** Returns the multiplication of a quaternion by a scalar. */
  def * (that: Double): Quaternion =
    Quaternion(w * that, x * that, y * that, z * that)

  /** Returns the division of a quaternion by a scalar. */
  def / (that: Double): Quaternion =
    Quaternion(w / that, x / that, y / that, z / that)

  /** A string representation of `this`. */
  override def toString: String =
    s"Rotation(yaw: ${yaw}, pitch: ${pitch}, roll: ${roll})"

object Quaternion:

  /** A quaternion whose 4 components are zero. */
  final val zero = Quaternion(0.0, 0.0, 0.0, 0.0)

  /** A unit quaternion representing the identity rotation. */
  final val identity = Quaternion(1.0, 0.0, 0.0, 0.0)

  /** Returns a unit quaternion from an axis-angle representation.
   *
   * @param axis The rotation axis as a normalized 3D vector.
   * @param angle: The magnitude of rotation.
   */
  def fromAxisAngle(axis: Vector3, angle: Angle): Quaternion =
    val h = angle.radians * 0.5
    val s = sin(h)
    Quaternion(cos(h), axis.x * s, axis.y * s, axis.z * s)

  /** Returns a unit quaternion from Euler angles.
    *
    * @param yaw The yaw angle.
    * @param pitch The pitch angle.
    * @param roll The roll angle.
    */
  def fromEuler(yaw: Angle, pitch: Angle, roll: Angle): Quaternion =
    val cy = cos(yaw.radians * 0.5)
    val sy = sin(yaw.radians * 0.5)
    val cp = cos(pitch.radians * 0.5)
    val sp = sin(pitch.radians * 0.5)
    val cr = cos(roll.radians * 0.5)
    val sr = sin(roll.radians * 0.5)
    Quaternion(
      cr * cp * cy + sr * sp * sy,
      sr * cp * cy - cr * sp * sy,
      cr * sp * cy + sr * cp * sy,
      cr * cp * sy - sr * sp * cy)

  /** Initializes a unit quaternion representing the rotation from one vector to another.
    *
    * @param source A vector.
    * @param target The vector obtained by applying the computed rotation.
    */
  def fromRotation(source: Vector3, target: Vector3, up: Vector3 = Vector3.unitY): Quaternion =
    val cos2Theta = source.dot(target)
    val vu = source.cross(target)
    val w = 1.0 + cos2Theta
    val l = sqrt(w * w + vu.x * vu.x + vu.y * vu.y + vu.z * vu.z)
    Quaternion(w / l, vu.x / l, vu.y / l, vu.z / l)

end Quaternion
