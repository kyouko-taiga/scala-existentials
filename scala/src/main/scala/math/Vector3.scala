package rays.math

import scala.math.sqrt

/** A 3-dimensional vector.
  *
  * 3D vectors are represented as distances along three orthogonal axes (x, y and z). They are used
  * for a variety of purposes (e.g., to describe positions, directions, scale factors, etc.). Thus,
  * the meaning of each component should be interpreted based on the context.
  *
  * @param x The vector's x-component.
  * @param y The vector's y-component.
  * @param z The vector's z-component.
  */
final case class Vector3(x: Double, y: Double, z: Double):

  /** The vector's magnitude (a.k.a. length or norm). */
  def magnitude: Double =
    sqrt(x * x + y * y + z * z)

  /** The vector's squared magnitude. */
  def squaredMagnitude: Double =
    x * x + y * y + z * z

  /** The vector, normalized. */
  def normalized: Vector3 =
    val l = magnitude
    if l != 0.0 then this / l else this

  /** Returns the dot (a.k.a. scalar) product of `this` with `that`. */
  def dot(that: Vector3): Double =
    x * that.x + y * that.y + z * that.z

  /** Computes the cross (a.k.a. vector) product of `this` vector with `that`.
    *
    * The cross product of two vectors `v`and `u` is a vector that is perpendicular to both `v` and
    * `u` and thus normal to the plane containing them.
    */
  def cross(that: Vector3): Vector3 =
    Vector3(y * that.z - z * that.y, z * that.x - x * that.z, x * that.y - y * that.x)

  /** Returns the Euclidean distance between `this` and `that`. */
  def distanceTo(that: Vector3): Double =
    (that - this).magnitude

  /** Returns the squared Euclidean distance between `this` and `that`. */
  def squaredDistanceTo(that: Vector3): Double =
    (that - this).squaredMagnitude

  /** Returns component-wise application of `combine` on the elements of `this` and `that`. */
  def combined(that: Vector3)(combine: (Double, Double) => Double): Vector3 =
    Vector3(combine(x, that.x), combine(y, that.y), combine(z, that.z))

  /** Returns the component-wise addition of two vectors. */
  def + (that: Vector3): Vector3 =
    Vector3(x + that.x, y + that.y, z + that.z)

  /** Returns the component-wise subtraction of two vectors. */
  def - (that: Vector3): Vector3 =
    Vector3(x - that.x, y - that.y, z - that.z)

  /** Returns the additive opposite of a vector. */
  def unary_- : Vector3 =
    Vector3(-x, -y, -z)

  /** Returns the component-wise multiplication of two vectors. */
  def * (that: Vector3): Vector3 =
    Vector3(x * that.x, y * that.y, z * that.z)

  /** Returns the multiplication of a vector by a scalar. */
  def * (that: Double): Vector3 =
    Vector3(x * that, y * that, z * that)

  /** Returns the rotation of a vector by a quaternion. */
  def * (that: Quaternion): Vector3 =
    val qvec = Vector3(that.x, that.y, that.z)
    var uv = qvec.cross(this)
    var uuv = qvec.cross(uv)
    uv = uv * (2.0 * that.w)
    uuv = uuv * 2.0
    this + uv + uuv

  /** Returns the component-wise division of two vectors. */
  def / (that: Vector3): Vector3 =
    Vector3(x / that.x, y / that.y, z / that.z)

  /** Returns the division of a vector by a scalar. */
  def / (that: Double): Vector3 =
    Vector3(x / that, y / that, z / that)

  /** A string representation of `this`. */
  override def toString: String =
    s"Vector3(${x}, ${y}, ${z})"

object Vector3:

  /** A vector whose 3 components are zero. */
  final val zero = Vector3(0.0, 0.0, 0.0)

  /** A vector whose 3 components are one. */
  final val unitScale = Vector3(1.0, 1.0, 1.0)

  /** A vector whose x-component is one and other components are zero. */
  final val unitX = Vector3(1.0, 0.0, 0.0)

  /** A vector whose y-component is one and other components are zero. */
  final val unitY = Vector3(0.0, 1.0, 0.0)

  /** A vector whose z-component is one and other components are zero. */
  final val unitZ = Vector3(0.0, 0.0, 1.0)

end Vector3
